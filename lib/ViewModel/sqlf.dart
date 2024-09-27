import 'dart:developer';
import 'dart:io';

import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../Model/questionFeildModel.dart';
import '../Model/questionModel.dart';

class DataBase {
  Future<Database> initializedDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'interview.db'),
      version: 3,
      onCreate: (Database db, int version) async {
        await db.execute(
          ''' CREATE TABLE interview(questions TEXT NOT NULL,answer TEXT NOT NULL,id INTEGER PRIMARY KEY ,level TEXT NOT NULL)''',
        );
      },
    );
  }

  // insert data
  Future<int> insertQuestions(List<QuestionsModel> interview) async {
    int result = 0;
    final Database db = await initializedDB();
    for (var inter in interview) {
      result = await db.insert('interview', inter.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }

    return result;
  }

  // retrieve data
  Future<List<QuestionsModel>> retrieveQuestions() async {
    final Database db = await initializedDB();
    final List<Map<String, Object?>> queryResult = await db.query('interview');
    return queryResult.map((e) => QuestionsModel.fromMap(e)).toList();
  }

  Future<List<QuestionsModel>> filterQuestions(String level) async {
    final Database db = await initializedDB();
    final List<Map<String, Object?>> queryResult = await db.query('interview',
        // columns: ['level'],
        where: '"level" == ?',
        whereArgs: [level]);
    return queryResult.map((e) => QuestionsModel.fromMap(e)).toList();
  }

  // delete user
  Future<void> deleteQuestions(int id) async {
    final db = await initializedDB();
    await db.delete(
      'interview',
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
