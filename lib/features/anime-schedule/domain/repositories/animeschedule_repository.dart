// domain/repositories/anime_schedule_repository.dart
import 'package:animedaily/features/anime-schedule/domain/entities/animeschedule.dart';


abstract class AnimeScheduleRepository {
  Future<List<AnimeSchedule>> getWeeklySchedule();
  Future<void> addAnime(AnimeSchedule anime);
  Future<void> updateAnime(AnimeSchedule anime);
  Future<void> deleteAnime(String id);
}
