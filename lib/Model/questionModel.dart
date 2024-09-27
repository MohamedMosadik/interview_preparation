import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class QuestionsModel {
  final String questions;
  final String answer;
  final int id;
  final String level;

  QuestionsModel({
    required this.questions,
    required this.answer,
    required this.id,
    required this.level,
  });
  factory QuestionsModel.fromFirestore(Map<String, dynamic> firestoreData) {
    return QuestionsModel(
      id: firestoreData['id'],
      questions: firestoreData['questions'],
      answer: firestoreData['answer'],
      level: firestoreData['level'],
    );
  }

  // factory QuestionsModel.fromFirestore(
  //   DocumentSnapshot<Map<String, dynamic>> snapshot,
  //   SnapshotOptions? options,
  // ) {
  //   final data = snapshot.data();
  //   return QuestionsModel(
  //     id: data?['id'],
  //     questions: data?['questions'],
  //     answer: data?['answer'],
  //     level: data?['level'],
  //   );
  // }

  Map<String, dynamic> toFirestore() {
    return {
      "id": id,
      "questions": questions,
      "answer": answer,
      "level": level,
    };
  }

  QuestionsModel.fromMap(Map<String, dynamic> result)
      : questions = result["questions"],
        answer = result["answer"],
        id = result["id"],
        level = result["level"];
  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    result.addAll({'questions': questions});
    result.addAll({'answer': answer});
    result.addAll({'id': id});
    result.addAll({'level': level});

    return result;
    // return {'questions': questions, 'answer': answer, 'id': id, 'level': level};
  }

  String toJson() => json.encode(toMap());
  factory QuestionsModel.fromJson(String source) =>
      QuestionsModel.fromMap(json.decode(source));
}
