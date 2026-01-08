// core/database/app_database.dart
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AppDatabase {
  static Database? _db;

  static Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  static Future<Database> _initDb() async {
    final path = join(await getDatabasesPath(), 'anime_day.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE anime_schedule (
            id TEXT PRIMARY KEY,
            title TEXT,
            day TEXT,
            episode INTEGER,
            notes TEXT
          )
        ''');
      },
    );
  }
}
