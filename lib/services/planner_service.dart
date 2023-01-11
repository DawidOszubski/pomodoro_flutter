import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodoro_flutter/models/planner_models/task_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tuple/tuple.dart';

import 'database_helper.dart';

class PlannerService {
  final dbTask = 'Task';

  Future<void> createTask(TaskModel taskModel) async {
    final db = await DatabaseHelper.getDB();
    try {
      await db.insert(dbTask, taskModel.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (e) {
      print(e);
    }
  }

  Future<List<TaskModel>?> getTasks({String? date}) async {
    final db = await DatabaseHelper.getDB();

    if (date == null) {
      final List<Map<String, dynamic>> maps = await db.query(dbTask);

      if (maps.isEmpty) {
        return null;
      }

      return List.generate(
          maps.length, (index) => TaskModel.fromJson(maps[index]));
    } else {
      final List<Map<String, dynamic>> maps = await db.rawQuery(
          "SELECT * FROM $dbTask WHERE date BETWEEN date('now') AND date('$date');");
      if (maps.isEmpty) {
        return null;
      }
      return List.generate(
          maps.length, (index) => TaskModel.fromJson(maps[index]));
    }
  }

  Future<void> updateTask({required TaskModel taskModel}) async {
    final db = await DatabaseHelper.getDB();
    try {
      await db.rawUpdate(
          'UPDATE $dbTask SET title = ?, description = ?, date = ?, isImportant = ?, isUrgent = ? WHERE id = ?',
          [
            taskModel.title,
            taskModel.description,
            taskModel.date,
            taskModel.isImportant,
            taskModel.isUrgent,
            taskModel.id
          ]);
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteTask(TaskModel taskModel) async {
    final db = await DatabaseHelper.getDB();
    await db.delete(
      dbTask,
      where: 'id = ?',
      whereArgs: [taskModel.id],
    );
  }

  Future<void> checkDoneTask(
      {required Tuple2<TaskModel, int> modelIsDone}) async {
    final db = await DatabaseHelper.getDB();
    try {
      await db.rawUpdate('UPDATE $dbTask SET isDone = ? WHERE id = ?',
          [modelIsDone.item2, modelIsDone.item1.id]);
    } catch (e) {
      print(e);
    }
  }
}

final plannerServiceProvider =
    Provider<PlannerService>((ref) => PlannerService());
