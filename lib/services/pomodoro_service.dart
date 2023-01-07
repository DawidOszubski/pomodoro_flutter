import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodoro_flutter/models/learn_models/pomodoro_set_model.dart';
import 'package:sqflite/sqflite.dart';

import 'database_helper.dart';

class PomodoroService {
  final dbNamePomodoroSet = 'PomodoroSet';

  Future<void> createPomodoroSet(PomodoroSetModel pomodoroSet) async {
    final db = await DatabaseHelper.getDB();
    try {
      await db.insert(dbNamePomodoroSet, pomodoroSet.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (e) {
      print(e);
    }
  }

  Future<List<PomodoroSetModel>?> getAllPomodoroSets() async {
    final db = await DatabaseHelper.getDB();

    final List<Map<String, dynamic>> maps = await db.query(dbNamePomodoroSet);

    if (maps.isEmpty) {
      return null;
    }

    return List.generate(
        maps.length, (index) => PomodoroSetModel.fromJson(maps[index]));
  }
}

final pomodoroServiceProvider =
    Provider<PomodoroService>((ref) => PomodoroService());
