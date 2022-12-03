import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const int _version = 1;
  static const String _dbName = "Pomodoro.db";

  static Future<Database> getDB() async {
    const flashcardSet =
        "CREATE TABLE FlashcardSet(id INTEGER PRIMARY KEY, title TEXT NOT NULL, subject TEXT, progressCount INTEGER, flashcardCount INTEGER );";
    const flashcards =
        "CREATE TABLE Flashcards(flashcard_id INTEGER PRIMARY KEY, question TEXT NOT NULL, answer_text TEXT, answer_T_F BOOLEAN, answer_multiple TEXT, FK_flashcard_set_id INTEGER NOT NULL,"
        "FOREIGN KEY (FK_flashcard_set_id) REFERENCES FlashcardSet (id) ON DELETE CASCADE);";
    return openDatabase(
      join(await getDatabasesPath(), _dbName),
      onCreate: (db, version) async {
        await db.execute(flashcardSet);
        await db.execute(flashcards);
      },
      version: _version,
    );
  }
}
