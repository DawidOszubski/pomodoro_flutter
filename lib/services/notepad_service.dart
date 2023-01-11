import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodoro_flutter/models/notepad_models/notepad_model.dart';
import 'package:sqflite/sqflite.dart';

import 'database_helper.dart';

class NotepadService {
  final dbNotepad = 'Notepad';

  Future<void> createNote(NotepadModel notepadModel) async {
    final db = await DatabaseHelper.getDB();
    try {
      await db.insert(dbNotepad, notepadModel.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (e) {
      print(e);
    }
  }

  Future<List<NotepadModel>?> getAllNotes() async {
    final db = await DatabaseHelper.getDB();

    final List<Map<String, dynamic>> maps = await db.query(dbNotepad);

    if (maps.isEmpty) {
      return null;
    }

    return List.generate(
        maps.length, (index) => NotepadModel.fromJson(maps[index]));
  }

  Future<void> updateNote({required NotepadModel notepadModel}) async {
    final db = await DatabaseHelper.getDB();
    try {
      await db.rawUpdate(
          'UPDATE $dbNotepad SET title = ?, description = ? WHERE id = ?',
          [notepadModel.title, notepadModel.description, notepadModel.id]);
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteNote(NotepadModel notepadModel) async {
    final db = await DatabaseHelper.getDB();
    await db.delete(
      dbNotepad,
      where: 'id = ?',
      whereArgs: [notepadModel.id],
    );
  }
}

final notepadServiceProvider =
    Provider<NotepadService>((ref) => NotepadService());
