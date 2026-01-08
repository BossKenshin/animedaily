// presentation/pages/add_edit_anime_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import 'package:animedaily/features/anime-schedule/domain/entities/animeschedule.dart';
import 'package:animedaily/features/anime-schedule/presentation/bloc/animeschedule_bloc.dart';
import 'package:animedaily/features/anime-schedule/presentation/bloc/animeschedule_event.dart';

class AddEditAnimePage extends StatefulWidget {
  final AnimeSchedule? anime;
  const AddEditAnimePage({super.key, this.anime});

  @override
  State<AddEditAnimePage> createState() => _AddEditAnimePageState();
}

class _AddEditAnimePageState extends State<AddEditAnimePage> {
  final _titleCtrl = TextEditingController();
  final _episodeCtrl = TextEditingController();
  final _notesCtrl = TextEditingController();
  String _day = 'Monday';

  // Cyber Theme Palette
  static const Color _bgColor = Color(0xFF0B0B0F);
  static const Color _surface = Color(0xFF16161D);
  static const Color _primary = Color(0xFFBB86FC); // Neon Purple
  static const Color _secondary = Color(0xFF03DAC6); // Teal accent

  @override
  void initState() {
    super.initState();
    if (widget.anime != null) {
      _titleCtrl.text = widget.anime!.title;
      _episodeCtrl.text = widget.anime!.episode?.toString() ?? '';
      _notesCtrl.text = widget.anime!.notes ?? '';
      _day = widget.anime!.day;
    }
  }

  InputDecoration _cyberInputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white38, fontSize: 14),
      prefixIcon: Icon(icon, color: _secondary, size: 20),
      filled: true,
      fillColor: Colors.black26,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.white.withOpacity(0.05)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: _primary, width: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.anime == null ? 'NEW ENTRY' : 'UPDATE ANIME',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            letterSpacing: 2,
            fontSize: 16,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            _buildHeaderSection(),
            const SizedBox(height: 30),
            
            // Main Input Container
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: _surface,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.white.withOpacity(0.05)),
              ),
              child: Column(
                children: [
                  TextField(
                    controller: _titleCtrl,
                    style: const TextStyle(color: Colors.white),
                    decoration: _cyberInputDecoration('Series Title', Icons.auto_awesome),
                  ),
                  const SizedBox(height: 16),
                  _buildDayDropdown(),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _episodeCtrl,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(color: Colors.white),
                    decoration: _cyberInputDecoration('Current Episode', Icons.tag),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _notesCtrl,
                    maxLines: 3,
                    style: const TextStyle(color: Colors.white),
                    decoration: _cyberInputDecoration('Quick Notes', Icons.sticky_note_2_outlined),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 40),
            
            // The Action Button
            _buildSaveButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "MANIFEST DATA",
          style: TextStyle(color: _primary, fontWeight: FontWeight.bold, letterSpacing: 1.5, fontSize: 12),
        ),
        const SizedBox(height: 8),
        const Text(
          "Enter anime details to sync with your schedule.",
          style: TextStyle(color: Colors.white60, fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildDayDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.black26,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _day,
          isExpanded: true,
          dropdownColor: _surface,
          icon: const Icon(Icons.expand_more, color: _secondary),
          items: ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday']
              .map((d) => DropdownMenuItem(
                    value: d,
                    child: Text(d, style: const TextStyle(color: Colors.white)),
                  ))
              .toList(),
          onChanged: (v) => setState(() => _day = v!),
        ),
      ),
    );
  }

  Widget _buildSaveButton() {
    return GestureDetector(
      onTap: _onSave,
      child: Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: const LinearGradient(
            colors: [_primary, Color(0xFF7C4DFF)],
          ),
          boxShadow: [
            BoxShadow(
              color: _primary.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: const Center(
          child: Text(
            "INITIALIZE SYNC",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.5,
            ),
          ),
        ),
      ),
    );
  }

  void _onSave() {
    final anime = AnimeSchedule(
      id: widget.anime?.id ?? const Uuid().v4(),
      title: _titleCtrl.text,
      day: _day,
      episode: int.tryParse(_episodeCtrl.text),
      notes: _notesCtrl.text,
    );

    context.read<AnimeBloc>().add(
          widget.anime == null ? AddAnimeEvent(anime) : UpdateAnimeEvent(anime),
        );

    Navigator.pop(context);
  }
}