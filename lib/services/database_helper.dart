import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const int _version = 1;
  static const String _dbName = "Pomodoro.db";

  static Future<Database> getDB() async {
    const flashcardSet =
        "CREATE TABLE FlashcardSet(id INTEGER PRIMARY KEY, title TEXT NOT NULL, subject TEXT, progressCount INTEGER, flashcardCount INTEGER );";
    const flashcards =
        "CREATE TABLE Flashcards(id INTEGER PRIMARY KEY, question TEXT NOT NULL, answerText TEXT, answerTF BOOLEAN, answerMultipleChoice TEXT, flashcardSetId INTEGER NOT NULL,FOREIGN KEY (flashcardSetId) REFERENCES FlashcardSet (id) ON DELETE CASCADE);";

    return openDatabase(
      join(await getDatabasesPath(), _dbName),
      onCreate: (db, version) async {
        await db.execute(flashcardSet);
        await db.execute(flashcards);
      },
      onConfigure: _onConfigure,
      version: _version,
    );
  }

  static Future _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }
}
