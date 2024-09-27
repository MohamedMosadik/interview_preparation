import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreationEvent {
  final RootIsolateToken isolateToken;
  final SendPort sendPort;

  CreationEvent(this.isolateToken, this.sendPort);
}

class DeletetionEvent {}

class ReadEvent {
  final String key;
  const ReadEvent(this.key);
}

class ReadResult {
  final String key;
  final String? content;
  const ReadResult(this.key, this.content);
}

class IsolateIO {
  IsolateIO._();

  final _toBgPort = Completer();
  final Map<Object, Completer> _completerMap = {};

  Isolate? _isolate;
  StreamSubscription? _fromBgListener;

  void start() async {
    RootIsolateToken rootIsolateToken = RootIsolateToken.instance!;
    ReceivePort fromBG = ReceivePort();

    _fromBgListener = fromBG.listen((message) {
      // setup process
      if (message is SendPort) {
        _toBgPort.complete(message);
        return;
      }

      if (message is ReadResult) {
        _completerMap['read:${message.key}']?.complete(message.content);
        _completerMap.remove('read:${message.key}');
      }
    });

    _isolate = await Isolate.spawn(
      (CreationEvent data) {
        final worker = IsolateWorker(data.isolateToken, data.sendPort);
        worker.listen();
      },
      CreationEvent(rootIsolateToken, fromBG.sendPort),
    );
  }

  Future<String?> readFromStorage(String key) async {
    // make sure isolate created with ports
    final port = await _toBgPort.future;

    // store completer
    final completer = Completer<String?>();
    _completerMap['read:$key'] = completer;

    // send key to be read
    port.send(ReadEvent(key));

    // return result
    return completer.future;
  }

  void stop() async {
    if (_toBgPort.isCompleted) {
      final port = await _toBgPort.future;
      port.send(DeletetionEvent());
    }
    _fromBgListener?.cancel();
    _isolate?.kill(priority: Isolate.immediate);
  }

  static final i = IsolateIO._();
}

class IsolateWorker {
  final RootIsolateToken rootIsolateToken;
  final SendPort toMain;
  // final SharedPreferences? sharedPreferences;

  StreamSubscription? subs;

  IsolateWorker(
    this.rootIsolateToken,
    this.toMain,
    //  {this.sharedPreferences
    // }
  ) {
    // Register the background isolate with the root isolate.
    BackgroundIsolateBinaryMessenger.ensureInitialized(rootIsolateToken);
  }

  void listen() {
    ReceivePort fromMain = ReceivePort();
    toMain.send(fromMain.sendPort);
    subs = fromMain.listen((message) => onMessage(message));
  }

  void onMessage(dynamic message) async {
    if (message is DeletetionEvent) {
      subs?.cancel();
      return;
    }
    final prefs = await _initSharedPreference();
    if (message is ReadEvent) {
      final rawJson = await prefs.get(message.key);
      toMain.send(ReadResult(message.key, rawJson.toString()));
    }
  }

  Future<SharedPreferences> _initSharedPreference() async {
    WidgetsFlutterBinding.ensureInitialized();
    return await SharedPreferences.getInstance();
  }
}
