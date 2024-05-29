import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:store/data/exception/exception.dart';
import 'package:store/features/chatbot/model/message_model.dart';

class Sqflite {
  static Database? _db;
  static Sqflite? _instance;

  Sqflite._interval();

  factory Sqflite.instance() {
    _instance ??= Sqflite._interval();
    return _instance!;
  }

  static Future<void> init() async {
    _instance = Sqflite._interval();

    await open();
  }

  // ! open database
  static Future<void> open() async {
    if (_db != null) {
      return;
    }
    try {
      final docsPath = await getApplicationDocumentsDirectory();
      final dbPath = join(docsPath.path, "chats.db");

      final db = await openDatabase(dbPath);
      _db = db;

      await db.execute('''
CREATE TABLE IF NOT EXISTS "chats" (
	"userId"	INTEGER NOT NULL,
	"message"	TEXT NOT NULL,
	PRIMARY KEY("userId" AUTOINCREMENT)
);''');
      // ! create chats table
    } on MissingPlatformDirectoryException catch (e) {
      throw DatabaseExceptionMessage(e.message.toString());
    } catch (e) {
      throw DatabaseExceptionMessage(e.toString());
    }
  }

  // ! close database
  static Future<void> close() async {
    final db = _db;
    if (db == null) {
      throw DatabaseIsNotOpen("Database is not open");
    } else {
      await db.close();
      _db = null;
    }
  }

  // ! get databaseOrThrow
  static Database _getDatabaseOrThrow() {
    final db = _db;
    if (db == null) {
      throw DatabaseIsNotOpen("Database is not open");
    } else {
      return db;
    }
  }

  // ! insert message
  Future<void> insertMessage(MessageModel message) async {
    final db = _getDatabaseOrThrow();
    try {
      await db.insert(
        'chats',
        {"message": message.toJson()},
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      print("done");
    } catch (e) {
      throw DatabaseExceptionMessage(e.toString());
    }
  }

  // ! get all messages
  Future<void> getAllMessage() async {
    final db = _getDatabaseOrThrow();
    final message = await db.query("chats");
    print(message);
    // return message.map((e) => MessageModel.);
  }
}
