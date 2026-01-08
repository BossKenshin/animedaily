import 'package:animedaily/features/anime-schedule/data/datasources/anime_local.dart';
import 'package:animedaily/features/anime-schedule/data/repositories/animeschedule_impl.dart';
import 'package:animedaily/features/anime-schedule/domain/usecases/animeschedule_usecases.dart';
import 'package:animedaily/features/anime-schedule/presentation/bloc/animeschedule_bloc.dart';
import 'package:animedaily/features/anime-schedule/presentation/bloc/animeschedule_event.dart';
import 'package:animedaily/features/anime-schedule/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart'; // Add this to pubspec.yaml for easy date formatting

void main() {
  // Ensure Flutter is initialized before doing anything else
  WidgetsFlutterBinding.ensureInitialized();
  
  final localDataSource = AnimeLocalDataSourceImpl();
  final repository = AnimeScheduleRepositoryImpl(localDataSource);

  runApp(
    BlocProvider(
      create: (_) => AnimeBloc(
        getWeeklySchedule: GetWeeklySchedule(repository),
        addAnime: AddAnime(repository),
        updateAnime: UpdateAnime(repository),
        deleteAnime: DeleteAnime(repository),
      )..add(LoadSchedule()),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Helper to get today's name (e.g., "Monday")
    final String todayName = DateFormat('EEEE').format(DateTime.now());

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AnimeDaily',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        primaryColor: const Color(0xFFBB86FC),
        
        // This is the CRITICAL fix for the white flash
        scaffoldBackgroundColor: const Color(0xFF0B0B0F),
        canvasColor: const Color(0xFF0B0B0F),
        
        // Theme customization for Cyber-Clean look
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFBB86FC),
          secondary: Color(0xFF03DAC6),
          surface: Color(0xFF16161D),
          background: Color(0xFF0B0B0F),
          error: Color(0xFFFF4B66),
        ),
        
        // Customizing the transition to be a smoother fade/zoom (Android style)
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
      ),
      home: HomePage(today: todayName),
    );
  }
}