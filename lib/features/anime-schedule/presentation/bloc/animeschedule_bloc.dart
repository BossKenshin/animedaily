// presentation/bloc/anime_bloc.dart
import 'package:animedaily/features/anime-schedule/domain/usecases/animeschedule_usecases.dart';
import 'package:animedaily/features/anime-schedule/presentation/bloc/animeschedule_event.dart';
import 'package:animedaily/features/anime-schedule/presentation/bloc/animeschedule_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnimeBloc extends Bloc<AnimeEvent, AnimeState> {
  final GetWeeklySchedule getWeeklySchedule;
  final AddAnime addAnime;
  final UpdateAnime updateAnime;
  final DeleteAnime deleteAnime;

  AnimeBloc({
    required this.getWeeklySchedule,
    required this.addAnime,
    required this.updateAnime,
    required this.deleteAnime,
  }) : super(AnimeInitial()) {
    on<LoadSchedule>(_onLoadSchedule);
    on<AddAnimeEvent>(_onAddAnime);
    on<UpdateAnimeEvent>(_onUpdateAnime);
    on<DeleteAnimeEvent>(_onDeleteAnime);
  }

  Future<void> _onLoadSchedule(
      LoadSchedule event, Emitter<AnimeState> emit) async {
    emit(AnimeLoading());
    try {
      final schedule = await getWeeklySchedule();
      emit(AnimeLoaded(schedule));
    } catch (e) {
      emit(AnimeError("Failed to fetch schedule: ${e.toString()}"));
    }
  }

  Future<void> _onAddAnime(
      AddAnimeEvent event, Emitter<AnimeState> emit) async {
    // Note: We don't necessarily emit Loading here to prevent 
    // the screen from flickering if the UI is handling the transition
    try {
      await addAnime(event.anime);
      final schedule = await getWeeklySchedule();
      emit(AnimeLoaded(schedule));
    } catch (e) {
      emit(AnimeError("Could not add anime."));
    }
  }

  Future<void> _onUpdateAnime(
      UpdateAnimeEvent event, Emitter<AnimeState> emit) async {
    try {
      await updateAnime(event.anime);
      final schedule = await getWeeklySchedule();
      emit(AnimeLoaded(schedule));
    } catch (e) {
      emit(AnimeError("Update failed."));
    }
  }

  Future<void> _onDeleteAnime(
      DeleteAnimeEvent event, Emitter<AnimeState> emit) async {
    try {
      await deleteAnime(event.id);
      final schedule = await getWeeklySchedule();
      emit(AnimeLoaded(schedule));
    } catch (e) {
      emit(AnimeError("Delete failed."));
    }
  }
}