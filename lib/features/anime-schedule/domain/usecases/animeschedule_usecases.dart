// domain/usecases/add_anime.dart


import 'package:animedaily/features/anime-schedule/domain/entities/animeschedule.dart';
import 'package:animedaily/features/anime-schedule/domain/repositories/animeschedule_repository.dart';

class AddAnime {
  final AnimeScheduleRepository repository;

  AddAnime(this.repository);

  Future<void> call(AnimeSchedule anime) {
    return repository.addAnime(anime);
  }
}

class UpdateAnime {
  final AnimeScheduleRepository repository;
  UpdateAnime(this.repository);

  Future<void> call(AnimeSchedule anime) {
    return repository.updateAnime(anime);
  }
}

class DeleteAnime {
  final AnimeScheduleRepository repository;
  DeleteAnime(this.repository);

  Future<void> call(String id) {
    return repository.deleteAnime(id);
  }
}


class GetWeeklySchedule {
  final AnimeScheduleRepository repository;

  GetWeeklySchedule(this.repository);

  Future<List<AnimeSchedule>> call() {
    return repository.getWeeklySchedule();
  }
}

