import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';
import 'package:pomodoro_flutter/models/flash_card_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const int _version = 1;
  static const String _dbName = "Pomodoro.db";

  static Future<Database> _getDB() async {
    return openDatabase(
      join(await getDatabasesPath(), _dbName),
      onCreate: (db, version) async => await db.execute(
          "CREATE TABLE Flashcard(id INTEGER PRIMARY KEY AUTO_INCREMENT, title TEXT NOT NULL, subject TEXT, progressCount INTEGER, flashcardCount INTEGER );"),
      version: _version,
    );
  }

  Future<int> addFlashcard(FlashCardModel flashCardModel) async {
    final db = await _getDB();
    return await db.insert("Flashcard", flashCardModel.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> updateFlashCard(FlashCardModel flashCardModel) async {
    final db = await _getDB();
    return await db.update(
      "Flashcard",
      flashCardModel.toJson(),
      where: 'id = ?',
      whereArgs: [flashCardModel.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> deleteFlashCard(FlashCardModel flashCardModel) async {
    final db = await _getDB();
    return await db.delete(
      "Flashcard",
      where: 'id = ?',
      whereArgs: [flashCardModel.id],
    );
  }

  Future<List<FlashCardModel>?> getAllFlashCards() async {
    final db = await _getDB();

    final List<Map<String, dynamic>> maps = await db.query("FlashCard");

    if (maps.isEmpty) {
      return null;
    }

    return List.generate(
        maps.length, (index) => FlashCardModel.fromJson(maps[index]));
  }
}

final flashcardServiceProvider =
    Provider<DatabaseHelper>((ref) => DatabaseHelper());
