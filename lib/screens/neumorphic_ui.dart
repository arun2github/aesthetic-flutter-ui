import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

class NeumorphicUIScreen extends StatefulWidget {
  const NeumorphicUIScreen({super.key});

  @override
  State<NeumorphicUIScreen> createState() => _NeumorphicUIScreenState();
}

class _NeumorphicUIScreenState extends State<NeumorphicUIScreen> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0E5EC),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 12,
          ), // 12px top margin for content
          child: Column(
            children: [
              // App bar
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: _buildNeumorphicButton(
                        child: const Icon(Icons.arrow_back_ios, size: 20),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      'Neumorphic UI',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF2D3748),
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    _buildNeumorphicCard(
                      title: 'Music Player',
                      subtitle: 'Now Playing',
                      icon: Icons.music_note,
                      delay: 0,
                    ),
                    _buildNeumorphicSlider(),
                    _buildNeumorphicButtons(),
                    _buildNeumorphicSwitch(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNeumorphicButton({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFE0E5EC),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.9),
            offset: const Offset(-8, -8),
            blurRadius: 16,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: const Offset(8, 8),
            blurRadius: 16,
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildNeumorphicCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required int delay,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFE0E5EC),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.9),
            offset: const Offset(-12, -12),
            blurRadius: 24,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: const Offset(12, 12),
            blurRadius: 24,
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFE0E5EC),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.9),
                      offset: const Offset(-8, -8),
                      blurRadius: 16,
                    ),
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      offset: const Offset(8, 8),
                      blurRadius: 16,
                    ),
                  ],
                ),
                child: Icon(icon, size: 48, color: const Color(0xFF4A5568)),
              )
              .animate(delay: Duration(milliseconds: delay))
              .scale(begin: const Offset(0, 0), end: const Offset(1, 1)),

          const SizedBox(height: 20),

          Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF2D3748),
                ),
              )
              .animate(delay: Duration(milliseconds: delay + 100))
              .fadeIn(duration: 600.ms)
              .slideY(begin: 0.3),

          const SizedBox(height: 8),

          Text(
                subtitle,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: const Color(0xFF718096),
                ),
              )
              .animate(delay: Duration(milliseconds: delay + 200))
              .fadeIn(duration: 600.ms)
              .slideY(begin: 0.3),
        ],
      ),
    );
  }

  Widget _buildNeumorphicSlider() {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFE0E5EC),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.9),
            offset: const Offset(-8, -8),
            blurRadius: 16,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: const Offset(8, 8),
            blurRadius: 16,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Volume Control',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF2D3748),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            height: 8,
            decoration: BoxDecoration(
              color: const Color(0xFFE0E5EC),
              borderRadius: BorderRadius.circular(4),
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.9),
                  offset: const Offset(-2, -2),
                  blurRadius: 4,
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  offset: const Offset(2, 2),
                  blurRadius: 4,
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 7,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF667eea), Color(0xFF764ba2)],
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFE0E5EC),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate(delay: 300.ms).fadeIn(duration: 600.ms).slideY(begin: 0.3);
  }

  Widget _buildNeumorphicButtons() {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNeumorphicButton(
                child: const Icon(Icons.skip_previous, size: 32),
              )
              .animate(delay: 400.ms)
              .scale(begin: const Offset(0, 0), end: const Offset(1, 1)),

          GestureDetector(
                onTapDown: (_) => setState(() => _isPressed = true),
                onTapUp: (_) => setState(() => _isPressed = false),
                onTapCancel: () => setState(() => _isPressed = false),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 100),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE0E5EC),
                    shape: BoxShape.circle,
                    boxShadow: _isPressed
                        ? [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.9),
                              offset: const Offset(-4, -4),
                              blurRadius: 8,
                            ),
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              offset: const Offset(4, 4),
                              blurRadius: 8,
                            ),
                          ]
                        : [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.9),
                              offset: const Offset(-8, -8),
                              blurRadius: 16,
                            ),
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              offset: const Offset(8, 8),
                              blurRadius: 16,
                            ),
                          ],
                  ),
                  child: Icon(
                    _isPressed ? Icons.pause : Icons.play_arrow,
                    size: 48,
                    color: const Color(0xFF4A5568),
                  ),
                ),
              )
              .animate(delay: 500.ms)
              .scale(begin: const Offset(0, 0), end: const Offset(1, 1)),

          _buildNeumorphicButton(child: const Icon(Icons.skip_next, size: 32))
              .animate(delay: 600.ms)
              .scale(begin: const Offset(0, 0), end: const Offset(1, 1)),
        ],
      ),
    );
  }

  Widget _buildNeumorphicSwitch() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFE0E5EC),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.9),
            offset: const Offset(-8, -8),
            blurRadius: 16,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: const Offset(8, 8),
            blurRadius: 16,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Auto Play',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF2D3748),
            ),
          ),
          Container(
            width: 60,
            height: 30,
            decoration: BoxDecoration(
              color: const Color(0xFFE0E5EC),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.9),
                  offset: const Offset(-2, -2),
                  blurRadius: 4,
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  offset: const Offset(2, 2),
                  blurRadius: 4,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(2),
              child: Container(
                width: 26,
                height: 26,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF667eea), Color(0xFF764ba2)],
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      offset: const Offset(1, 1),
                      blurRadius: 2,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ).animate(delay: 700.ms).fadeIn(duration: 600.ms).slideY(begin: 0.3);
  }
}
