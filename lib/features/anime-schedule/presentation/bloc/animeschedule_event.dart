// presentation/bloc/anime_event.dart
import 'package:animedaily/features/anime-schedule/domain/entities/animeschedule.dart';
import 'package:equatable/equatable.dart';

abstract class AnimeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadSchedule extends AnimeEvent {}

class AddAnimeEvent extends AnimeEvent {
  final AnimeSchedule anime;
  AddAnimeEvent(this.anime);

  @override
  List<Object?> get props => [anime];
}

class UpdateAnimeEvent extends AnimeEvent {
  final AnimeSchedule anime;
  UpdateAnimeEvent(this.anime);

  @override
  List<Object?> get props => [anime];
}

class DeleteAnimeEvent extends AnimeEvent {
  final String id;
  DeleteAnimeEvent(this.id);

  @override
  List<Object?> get props => [id];
}
