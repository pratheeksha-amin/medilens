import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await initDatabase();
    return _database!;
  }

  static Future<Database> initDatabase() async {
    String path = join(
      await getDatabasesPath(),
      "medilens.db",
    );

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE medicines(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          uses TEXT,
          dosage TEXT,
          sideEffects TEXT,
          warnings TEXT,
          storage TEXT,
          language TEXT,
          favorite INTEGER,
          scannedDate TEXT
        )
        ''');
      },
    );
  }
}