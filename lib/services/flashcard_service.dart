import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodoro_flutter/services/database_helper.dart';
import 'package:sqflite/sqflite.dart';

import '../models/flashcards_model/flash_card_model.dart';

class FlashcardService {
  Future<int> createFlashcardSet(FlashCardModel flashCardModel) async {
    final db = await DatabaseHelper.getDB();
    return await db.insert("Flashcard", flashCardModel.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> updateFlashcardSet(FlashCardModel flashCardModel) async {
    final db = await DatabaseHelper.getDB();
    return await db.update(
      "Flashcard",
      flashCardModel.toJson(),
      where: 'id = ?',
      whereArgs: [flashCardModel.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> deleteFlashcardSet(FlashCardModel flashCardModel) async {
    final db = await DatabaseHelper.getDB();
    return await db.delete(
      "Flashcard",
      where: 'id = ?',
      whereArgs: [flashCardModel.id],
    );
  }

  Future<List<FlashCardModel>?> getAllFlashcardSets() async {
    final db = await DatabaseHelper.getDB();

    final List<Map<String, dynamic>> maps = await db.query("FlashCard");

    if (maps.isEmpty) {
      return null;
    }

    return List.generate(
        maps.length, (index) => FlashCardModel.fromJson(maps[index]));
  }
}

final flashcardServiceProvider =
    Provider<FlashcardService>((ref) => FlashcardService());
