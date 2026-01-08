// presentation/pages/weekly_page.dart
import 'package:animedaily/features/anime-schedule/presentation/bloc/animeschedule_bloc.dart';
import 'package:animedaily/features/anime-schedule/presentation/bloc/animeschedule_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class WeeklyPage extends StatelessWidget {
  const WeeklyPage({super.key});

  static const days = [
    'Monday','Tuesday','Wednesday',
    'Thursday','Friday','Saturday','Sunday'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Weekly Schedule')),
      body: BlocBuilder<AnimeBloc, AnimeState>(
        builder: (context, state) {
          if (state is AnimeLoaded) {
            return ListView(
              children: days.map((day) {
                final list =
                    state.schedule.where((e) => e.day == day).toList();

                return ExpansionTile(
                  title: Text(day),
                  children: list.isEmpty
                      ? [const ListTile(title: Text('No anime'))]
                      : list.map((anime) {
                          return ListTile(
                            title: Text(anime.title),
                            subtitle: Text(
                              'Ep: ${anime.episode ?? '-'}',
                            ),
                          );
                        }).toList(),
                );
              }).toList(),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
