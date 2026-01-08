// presentation/bloc/anime_state.dart
import 'package:animedaily/features/anime-schedule/domain/entities/animeschedule.dart';
import 'package:equatable/equatable.dart';

abstract class AnimeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AnimeInitial extends AnimeState {}

class AnimeLoaded extends AnimeState {
  final List<AnimeSchedule> schedule;

  AnimeLoaded(this.schedule);

  @override
  List<Object?> get props => [schedule];
}

class AnimeError extends AnimeState {
  final String message;

  AnimeError(this.message);

  @override
  List<Object?> get props => [message];
}

class AnimeLoading extends AnimeState {}
