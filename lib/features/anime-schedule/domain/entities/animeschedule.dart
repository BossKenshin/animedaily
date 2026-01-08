// domain/entities/anime_schedule.dart
import 'package:equatable/equatable.dart';

class AnimeSchedule extends Equatable {
  final String id;
  final String title;
  final String day;
  final int? episode;
  final String? notes;

  const AnimeSchedule({
    required this.id,
    required this.title,
    required this.day,
    this.episode,
    this.notes,
  });

  @override
  List<Object?> get props => [id, title, day, episode, notes];
}
