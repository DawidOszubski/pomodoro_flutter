import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodoro_flutter/services/database_helper.dart';
import 'package:sqflite/sqflite.dart';

import '../models/flashcards_model/flash_card_model.dart';

class FlashcardService {
  final dbNameFLashCardSet = 'FlashcardSet';

  Future<int> createFlashcardSet(FlashCardModel flashCardModel) async {
    final db = await DatabaseHelper.getDB();
    try {
      return await db.insert(dbNameFLashCardSet, flashCardModel.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (e) {
      print(e);
      return 0;
    }
  }

  Future<int> updateFlashcardSet(FlashCardModel flashCardModel) async {
    final db = await DatabaseHelper.getDB();
    return await db.update(
      dbNameFLashCardSet,
      flashCardModel.toJson(),
      where: 'id = ?',
      whereArgs: [flashCardModel.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> deleteFlashcardSet(FlashCardModel flashCardModel) async {
    final db = await DatabaseHelper.getDB();
    return await db.delete(
      dbNameFLashCardSet,
      where: 'id = ?',
      whereArgs: [flashCardModel.id],
    );
  }

  Future<List<FlashCardModel>?> getAllFlashcardSets() async {
    final db = await DatabaseHelper.getDB();

    final List<Map<String, dynamic>> maps = await db.query(dbNameFLashCardSet);

    if (maps.isEmpty) {
      return null;
    }

    return List.generate(
        maps.length, (index) => FlashCardModel.fromJson(maps[index]));
  }

  Future<int> changeFlashcardSetName(
      {required FlashCardModel flashcard}) async {
    final db = await DatabaseHelper.getDB();
    try {
      return await db.rawUpdate(
          'UPDATE $dbNameFLashCardSet SET title = ? WHERE id = ?',
          [flashcard.title, flashcard.id]);
    } catch (e) {
      print(e);
      return 0;
    }
  }

  /*Future<int> createFlashcard(FlashCardModel flashCardModel) async {
    final db = await DatabaseHelper.getDB();
    try {
      return await db.insert(dbNameFLashCardSet, flashCardModel.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (e) {
      print(e);
      return 0;
    }
  }*/
}

final flashcardServiceProvider =
    Provider<FlashcardService>((ref) => FlashcardService());
