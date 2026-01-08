// presentation/pages/home_page.dart
import 'package:animedaily/features/anime-schedule/presentation/pages/about_page.dart';
import 'package:animedaily/features/anime-schedule/presentation/pages/add_edit_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animedaily/features/anime-schedule/presentation/bloc/animeschedule_bloc.dart';
import 'package:animedaily/features/anime-schedule/presentation/bloc/animeschedule_event.dart'; // Ensure this is imported
import 'package:animedaily/features/anime-schedule/presentation/bloc/animeschedule_state.dart';

class HomePage extends StatefulWidget {
  final String today;
  const HomePage({super.key, required this.today});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // State for our filter: 'All' means Full Week, otherwise specific day
  late String selectedFilter;

  static const Color _primary = Color(0xFFBB86FC);
  static const Color _secondary = Color(0xFF03DAC6);
  final List<String> days = [
    'All',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  @override
  void initState() {
    super.initState();
    selectedFilter = widget.today; // Default to Today
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0B0F),
      body: BlocBuilder<AnimeBloc, AnimeState>(
        builder: (context, state) {
          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              _buildModernAppBar(),

              // 1. The Horizontal Filter Bar
              SliverToBoxAdapter(
                child: Container(
                  height: 60,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    itemCount: days.length,
                    itemBuilder: (context, index) =>
                        _buildFilterChip(days[index]),
                  ),
                ),
              ),

              if (state is AnimeLoaded)
                _buildFilteredList(state.schedule)
              else if (state is AnimeLoading)
                const SliverFillRemaining(
                  child: Center(
                    child: CircularProgressIndicator(color: _primary),
                  ),
                )
              else
                const SliverFillRemaining(
                  child: Center(
                    child: Text(
                      "Summoning your list...",
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: _primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const AddEditAnimePage()),
        ),
        child: const Icon(Icons.bolt, color: Colors.black, size: 30),
      ),
    );
  }

  Widget _buildFilterChip(String day) {
    bool isSelected = selectedFilter == day;
    return GestureDetector(
      onTap: () => setState(() => selectedFilter = day),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: isSelected ? _primary : const Color(0xFF16161D),
          borderRadius: BorderRadius.circular(30),
          boxShadow: isSelected
              ? [BoxShadow(color: _primary.withOpacity(0.4), blurRadius: 10)]
              : [],
        ),
        child: Center(
          child: Text(
            day,
            style: TextStyle(
              color: isSelected ? Colors.black : Colors.white54,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFilteredList(List<dynamic> fullSchedule) {
    // UI-side filtering logic
    final filteredList = selectedFilter == 'All'
        ? fullSchedule
        : fullSchedule.where((e) => e.day == selectedFilter).toList();

    if (filteredList.isEmpty) {
      return SliverFillRemaining(
        child: Center(
          child: Text(
            "No anime scheduled for $selectedFilter",
            style: const TextStyle(color: Colors.white24),
          ),
        ),
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => _AnimeScheduleTile(anime: filteredList[index]),
          childCount: filteredList.length,
        ),
      ),
    );
  }

  Widget _buildModernAppBar() {
    return SliverAppBar(
      expandedHeight: 80,
      backgroundColor: const Color(0xFF0B0B0F),
      title: const Text(
        "AnimeDaily",
        style: TextStyle(
          fontWeight: FontWeight.w900,
          letterSpacing: 3,
          fontSize: 18,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.info_outline, color: Colors.white54),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AboutPage()),
          ),
        ),
      ],
    );
  }
}

class _AnimeScheduleTile extends StatelessWidget {
  final dynamic anime;
  const _AnimeScheduleTile({required this.anime});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Dismissible(
        key: Key(anime.id), // Ensure your entity has an ID
        direction: DismissDirection.endToStart,
        onDismissed: (direction) {
          context.read<AnimeBloc>().add(DeleteAnimeEvent(anime.id));
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("${anime.title} removed from schedule"),
              backgroundColor: const Color(0xFF16161D),
            ),
          );
        },
        background: _buildDeleteBackground(),
        child: GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddEditAnimePage(anime: anime)),
          ),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF16161D),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withOpacity(0.05)),
              gradient: LinearGradient(
                colors: [Colors.white.withOpacity(0.05), Colors.transparent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              children: [
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: const Color(0xFFBB86FC).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Icon(
                    Icons.play_circle_filled,
                    color: Color(0xFFBB86FC),
                    size: 30,
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        anime.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(
                            Icons.layers_outlined,
                            size: 14,
                            color: Color(0xFF03DAC6),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            "Episode ${anime.episode ?? '??'}",
                            style: const TextStyle(
                              color: Colors.white60,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right, color: Colors.white24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDeleteBackground() {
    return Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 25),
      decoration: BoxDecoration(
        color: const Color(0xFFFF4B66), // Cyber Pink/Red
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.delete_sweep_rounded, color: Colors.white, size: 30),
          Text(
            "DELETE",
            style: TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
