import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:interview_preparation/View/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'View/login_screen.dart';
import 'ViewModel/AuthProvider.dart';
import 'ViewModel/connectInternet.dart';
import 'ViewModel/isolate.dart';
import 'ViewModel/themeProvider.dart';
import 'firebase_options.dart';

Future<SharedPreferences> _initSharedPreference() async {
  WidgetsFlutterBinding.ensureInitialized();
  return await SharedPreferences.getInstance();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await _initSharedPreference();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp(
    prefs: prefs,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.prefs,
  });
  final SharedPreferences prefs;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationProvider>(
          create: (_) => AuthenticationProvider(FirebaseAuth.instance),
        ),
        // StreamProvider( create: (_) => ConnectivityService().connectionStatusController.stream,)

        StreamProvider<ConnectivityStatus>(
          initialData: ConnectivityStatus.WiFi,
          create: (context) =>
              ConnectivityService().connectionStatusController.stream,
        ),
        ChangeNotifierProvider<ThemeProvider>(
            create: (context) => ThemeProvider(prefs: prefs)),
        // StreamProvider(
        //     initialData: ConnectivityStatus.init,
        //     create: (context) =>
        //         ConnectivityService().connectivity.onConnectivityChanged),

        //     StreamProvider<ConnectivityStatus>(
        //       initialData: ConnectivityStatus.Init,
        //       create: (context) {

        //       },
        // builder: (context,child) => ConnectivityService())
        // StreamProvider(
        //   create: (context) => context.read<AuthenticationProvider>().authState, initialData: null,
        // )
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: themeProvider.attrs.colors,
            home: FirebaseAuth.instance.currentUser != null
                ? HomeScreen()
                : LoginScreen(),
          );
        },
      ),
    );
  }
}
