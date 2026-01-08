import 'package:animedaily/features/anime-schedule/data/datasources/anime_local.dart';
import 'package:animedaily/features/anime-schedule/data/models/animeschedule_model.dart';
import 'package:animedaily/features/anime-schedule/domain/entities/animeschedule.dart';
import 'package:animedaily/features/anime-schedule/domain/repositories/animeschedule_repository.dart';


class AnimeScheduleRepositoryImpl implements AnimeScheduleRepository {
  final AnimeLocalDataSourceImpl localDataSource;

  AnimeScheduleRepositoryImpl(this.localDataSource);

  @override
  Future<List<AnimeSchedule>> getWeeklySchedule() async {
    return await localDataSource.getAll();
  }

  @override
  Future<void> addAnime(AnimeSchedule anime) async {
    await localDataSource.add(
      AnimeScheduleModel(
        id: anime.id,
        title: anime.title,
        day: anime.day,
        episode: anime.episode,
        notes: anime.notes,
      ),
    );
  }

  @override
  Future<void> updateAnime(AnimeSchedule anime) async {
    await localDataSource.update(
      AnimeScheduleModel(
        id: anime.id,
        title: anime.title,
        day: anime.day,
        episode: anime.episode,
        notes: anime.notes,
      ),
    );
  }

  @override
  Future<void> deleteAnime(String id) async {
    await localDataSource.delete(id);
  }
}
