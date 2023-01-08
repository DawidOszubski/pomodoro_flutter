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
}

final notepadServiceProvider =
    Provider<NotepadService>((ref) => NotepadService());
