import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const int _version = 2;
  static const String _dbName = "Pomodoro.db";

  static Future<Database> getDB() async {
    return openDatabase(
      join(await getDatabasesPath(), _dbName),
      onCreate: (db, version) async {
        await db.execute(
            "CREATE TABLE FlashcardSet(flashcard_set_id INTEGER PRIMARY KEY, title TEXT NOT NULL, subject TEXT, progressCount INTEGER, flashcardCount INTEGER );");
        await db.execute(
            "CREATE TABLE Flashcards(flashcard_id INTEGER PRIMARY KEY, question TEXT NOT NULL, answer_text TEXT, answer_T_F NUMBER(1), answer_multiple TEXT, FK_flashcard_set_id INTEGER NOT NULL,"
            "FOREIGN KEY (FK_flashcard_set_id) REFERENCES FlashcardSet (flashcard_set_id) ON DELETE CASCADE);");
      },
      version: _version,
    );
  }
}
