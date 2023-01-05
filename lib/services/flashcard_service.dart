import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodoro_flutter/models/flashcards_model/flashcard_item_model.dart';
import 'package:pomodoro_flutter/services/database_helper.dart';
import 'package:sqflite/sqflite.dart';

import '../models/flashcards_model/flash_card_model.dart';

class FlashcardService {
  final dbNameFlashCardSet = 'FlashcardSet';
  final dbNameFlashCards = 'Flashcards';

  Future<int> createFlashcardSet(FlashCardModel flashCardModel) async {
    final db = await DatabaseHelper.getDB();
    try {
      return await db.insert(dbNameFlashCardSet, flashCardModel.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (e) {
      return 0;
    }
  }

  Future<int> updateFlashcardSet(FlashCardModel flashCardModel) async {
    final db = await DatabaseHelper.getDB();
    return await db.update(
      dbNameFlashCardSet,
      flashCardModel.toJson(),
      where: 'id = ?',
      whereArgs: [flashCardModel.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> deleteFlashcardSet(FlashCardModel flashCardModel) async {
    final db = await DatabaseHelper.getDB();
    return await db.delete(
      dbNameFlashCardSet,
      where: 'id = ?',
      whereArgs: [flashCardModel.id],
    );
  }

  Future<List<FlashCardModel>?> getAllFlashcardSets() async {
    final db = await DatabaseHelper.getDB();

    final List<Map<String, dynamic>> maps = await db.query(dbNameFlashCardSet);

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
          'UPDATE $dbNameFlashCardSet SET title = ? WHERE id = ?',
          [flashcard.title, flashcard.id]);
    } catch (e) {
      print(e);
      return 0;
    }
  }

  Future<int> updateNumberOfFlashcards({
    required int flashcardSetId,
  }) async {
    final db = await DatabaseHelper.getDB();
    final numberOfFlashcards =
        await getNumberOfFlashcardsFromSet(flashcardSetId: flashcardSetId);
    try {
      if (numberOfFlashcards == 0) {
        return await db.rawUpdate(
            'UPDATE $dbNameFlashCardSet SET flashcardCount = ?, progressCount = ? WHERE id = ?',
            [numberOfFlashcards, 0, flashcardSetId]);
      } else {
        return await db.rawUpdate(
            'UPDATE $dbNameFlashCardSet SET flashcardCount = ? WHERE id = ?',
            [numberOfFlashcards, flashcardSetId]);
      }
    } catch (e) {
      print(e);
      return 0;
    }
  }

  Future<int> getNumberOfFlashcardsFromSet(
      {required int flashcardSetId}) async {
    final db = await DatabaseHelper.getDB();
    try {
      int? count = Sqflite.firstIntValue(await db.rawQuery(
          'SELECT COUNT(*) FROM $dbNameFlashCards WHERE flashcardSetId = $flashcardSetId'));
      if (count != null) {
        return count;
      } else {
        return 0;
      }
    } catch (e) {
      print(e);
      return 0;
    }
  }

  Future<int> createFlashcard({
    required FlashcardItemModel flashCardItemModel,
  }) async {
    final db = await DatabaseHelper.getDB();
    try {
      return await db
          .insert(dbNameFlashCards, flashCardItemModel.toJson(),
              conflictAlgorithm: ConflictAlgorithm.replace)
          .then((value) {
        debugPrint('Dodano nową fiszkę');
        return updateNumberOfFlashcards(
            flashcardSetId: flashCardItemModel.flashcardSetId);
      });
    } catch (e) {
      print(e);
      return 0;
    }
  }

  Future<void> updateFlashcard({
    required FlashcardItemModel flashCardItemModel,
  }) async {
    final db = await DatabaseHelper.getDB();
    try {
      await db.rawUpdate(
          'UPDATE $dbNameFlashCards SET question = ?, answerText = ? WHERE id = ?',
          [
            flashCardItemModel.question,
            flashCardItemModel.answerText,
            flashCardItemModel.id
          ]);
    } catch (e) {
      print(e);
    }
  }

  Future<List<FlashcardItemModel>?> getAllFlashcardsInSet(
      {required int flashcardSetId}) async {
    final db = await DatabaseHelper.getDB();
    try {
      final List<Map<String, dynamic>> maps = await db.rawQuery(
          'SELECT * FROM $dbNameFlashCards WHERE flashcardSetId = $flashcardSetId');
      if (maps.isEmpty) {
        return null;
      }
      return List.generate(
          maps.length, (index) => FlashcardItemModel.fromJson(maps[index]));
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<void> deleteFlashcard(FlashcardItemModel flashCard) async {
    final db = await DatabaseHelper.getDB();
    await db.delete(
      dbNameFlashCards,
      where: 'id = ?',
      whereArgs: [flashCard.id],
    ).then(
      (value) =>
          updateNumberOfFlashcards(flashcardSetId: flashCard.flashcardSetId),
    );
  }
}

final flashcardServiceProvider =
    Provider<FlashcardService>((ref) => FlashcardService());
