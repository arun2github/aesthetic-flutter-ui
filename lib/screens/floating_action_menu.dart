import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';

class FloatingActionMenuScreen extends StatefulWidget {
  const FloatingActionMenuScreen({super.key});

  @override
  State<FloatingActionMenuScreen> createState() =>
      _FloatingActionMenuScreenState();
}

class _FloatingActionMenuScreenState extends State<FloatingActionMenuScreen>
    with TickerProviderStateMixin {
  bool _isMenuOpen = false;
  late AnimationController _menuController;
  late Animation<double> _menuAnimation;

  @override
  void initState() {
    super.initState();
    _menuController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _menuAnimation = CurvedAnimation(
      parent: _menuController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _menuController.dispose();
    super.dispose();
  }

  void _toggleMenu() {
    setState(() {
      _isMenuOpen = !_isMenuOpen;
    });

    if (_isMenuOpen) {
      _menuController.forward();
    } else {
      _menuController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: Column(
            children: [
              // App bar
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white.withOpacity(0.1),
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      'Floating Action Menu',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Tap the floating button',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          color: Colors.white70,
                        ),
                      ).animate().fadeIn(duration: 600.ms),

                      const SizedBox(height: 8),

                      Text(
                        'to open the menu',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.white.withOpacity(0.5),
                        ),
                      ).animate(delay: 200.ms).fadeIn(duration: 600.ms),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Stack(
        children: [
          // Menu items
          ...List.generate(4, (index) {
            final angle = (index * 90) * (3.14159 / 180);
            final radius = 120.0;

            return AnimatedBuilder(
              animation: _menuAnimation,
              builder: (context, child) {
                final offset = _isMenuOpen
                    ? radius * _menuAnimation.value
                    : 0.0;

                return Positioned(
                  left: 28 + offset * cos(angle),
                  bottom: 28 + offset * sin(angle),
                  child: Transform.scale(
                    scale: _menuAnimation.value,
                    child: Opacity(
                      opacity: _menuAnimation.value,
                      child: _buildMenuItem(index),
                    ),
                  ),
                );
              },
            );
          }),

          // Main floating action button
          FloatingActionButton(
            onPressed: _toggleMenu,
            backgroundColor: const Color(0xFF6366F1),
            child: AnimatedRotation(
              turns: _isMenuOpen ? 0.125 : 0,
              duration: const Duration(milliseconds: 300),
              child: const Icon(Icons.add, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(int index) {
    final icons = [Icons.camera_alt, Icons.photo, Icons.videocam, Icons.mic];
    final colors = [
      const Color(0xFFEF4444),
      const Color(0xFF10B981),
      const Color(0xFFF59E0B),
      const Color(0xFF8B5CF6),
    ];
    final labels = ['Camera', 'Photo', 'Video', 'Voice'];

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: colors[index],
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: colors[index].withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Icon(icons[index], color: Colors.white, size: 24),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.7),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            labels[index],
            style: GoogleFonts.poppins(fontSize: 12, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
