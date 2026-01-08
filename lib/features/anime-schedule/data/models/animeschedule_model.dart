// data/models/anime_schedule_model.dart

import 'package:animedaily/features/anime-schedule/domain/entities/animeschedule.dart';

class AnimeScheduleModel extends AnimeSchedule {
  const AnimeScheduleModel({
    required super.id,
    required super.title,
    required super.day,
    super.episode,
    super.notes,
  });

  factory AnimeScheduleModel.fromMap(Map<String, dynamic> map) {
    return AnimeScheduleModel(
      id: map['id'],
      title: map['title'],
      day: map['day'],
      episode: map['episode'],
      notes: map['notes'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'day': day,
      'episode': episode,
      'notes': notes,
    };
  }
}
