// data/datasources/anime_local_datasource.dart
import 'package:animedaily/core/database/app_database.dart';
import 'package:animedaily/features/anime-schedule/data/models/animeschedule_model.dart';
import 'package:sqflite/sqflite.dart';


class AnimeLocalDataSourceImpl {
  Future<Database> get _db async => AppDatabase.database;

  Future<List<AnimeScheduleModel>> getAll() async {
    final db = await _db;
    final res = await db.query('anime_schedule');
    return res.map((e) => AnimeScheduleModel.fromMap(e)).toList();
  }

  Future<void> add(AnimeScheduleModel anime) async {
    final db = await _db;
    await db.insert('anime_schedule', anime.toMap());
  }

  Future<void> update(AnimeScheduleModel anime) async {
    final db = await _db;
    await db.update(
      'anime_schedule',
      anime.toMap(),
      where: 'id = ?',
      whereArgs: [anime.id],
    );
  }

  Future<void> delete(String id) async {
    final db = await _db;
    await db.delete('anime_schedule', where: 'id = ?', whereArgs: [id]);
  }
}
