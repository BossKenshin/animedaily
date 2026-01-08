// presentation/pages/about_page.dart
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  static const Color _primary = Color(0xFFBB86FC); // Neon Purple
  static const Color _secondary = Color(0xFF03DAC6); // Teal accent
  static const Color _surface = Color(0xFF16161D);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0B0F),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "ABOUT",
          style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 2, fontSize: 16),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 20),
            _buildProfileHeader(),
            const SizedBox(height: 40),
            _buildInfoCard(
              title: "DEVELOPER",
              value: "Christian Lawrence Rosales",
              icon: Icons.person_outline,
            ),
            const SizedBox(height: 16),
            _buildInfoCard(
              title: "CONTACT",
              value: "r.christianlawrence13@gmail.com",
              icon: Icons.alternate_email,
            ),
            const SizedBox(height: 16),
            _buildInfoCard(
              title: "SOCIAL",
              value: "fb.me/Christian Lawrence Rosales",
              icon: Icons.facebook,
            ),
            const SizedBox(height: 16),
            _buildInfoCard(
              title: "LOCATION",
              value: "Cebu, Philippines",
              icon: Icons.location_on_outlined,
            ),
            const SizedBox(height: 60),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Center(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(colors: [_primary, _secondary]),
            ),
            child: const CircleAvatar(
              radius: 60,
              backgroundColor: Color(0xFF0B0B0F),
              child: Icon(Icons.code_rounded, size: 50, color: _primary),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            "DEVELOPER LOG",
            style: TextStyle(color: _secondary, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 4),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard({required String title, required String value, required IconData icon}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          Icon(icon, color: _primary, size: 24),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.5),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Opacity(
      opacity: 0.3,
      child: Column(
        children: [
          const Text(
            "AnimeDaily v1.0.0",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            "Built with Passion & Love to Anime",
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
    );
  }
}