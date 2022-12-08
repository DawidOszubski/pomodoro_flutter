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
      print(e);
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
          'SELECT COUNT(*) FROM $dbNameFlashCards WHERE FK_flashcard_set_id = $flashcardSetId'));
      if (count != null) {
        return count;
      } else {
        return 0;
      }
      /*final List<Map<String, dynamic>> maps = await db.query(dbNameFlashCards);

      if (maps.isEmpty) {
        return 0;
      }

      return List.generate(
              maps.length, (index) => FlashcardItemModel.fromJson(maps[index]))
          .length;*/
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
      return await db.rawInsert(
          'INSERT INTO $dbNameFlashCards (question, answer_text,answer_T_F,answer_multiple, FK_flashcard_set_id) VALUES(?, ?, ?,?,? )',
          [
            flashCardItemModel.question,
            flashCardItemModel.answerText,
            flashCardItemModel.answerTF,
            flashCardItemModel.answerMultipleChoice,
            flashCardItemModel.flashcardSetId,
          ]).then((value) {
        debugPrint('Dodano nową fiszkę');
        return updateNumberOfFlashcards(
            flashcardSetId: flashCardItemModel.flashcardSetId);
      });
    } catch (e) {
      print(e);
      return 0;
    }
  }

  Future<List<FlashcardItemModel>?> getAllFlashcardsInSet() async {
    final db = await DatabaseHelper.getDB();
    try {
      final List<Map<String, dynamic>> maps = await db.query(dbNameFlashCards);

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
}

final flashcardServiceProvider =
    Provider<FlashcardService>((ref) => FlashcardService());
