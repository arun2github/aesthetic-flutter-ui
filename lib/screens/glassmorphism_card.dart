import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';

class GlassmorphismCardScreen extends StatefulWidget {
  const GlassmorphismCardScreen({super.key});

  @override
  State<GlassmorphismCardScreen> createState() =>
      _GlassmorphismCardScreenState();
}

class _GlassmorphismCardScreenState extends State<GlassmorphismCardScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    );
    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF667eea),
              const Color(0xFF764ba2),
              const Color(0xFFf093fb),
              const Color(0xFFf5576c),
            ],
          ),
        ),
        child: Stack(
          children: [
            // Animated background circles
            Positioned(
              top: -100,
              left: -100,
              child: AnimatedBuilder(
                animation: _rotationAnimation,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _rotationAnimation.value * 2 * 3.14159,
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            Colors.white.withOpacity(0.1),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Positioned(
              bottom: -50,
              right: -50,
              child: AnimatedBuilder(
                animation: _rotationAnimation,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: -_rotationAnimation.value * 2 * 3.14159,
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            Colors.white.withOpacity(0.1),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Main content
            SafeArea(
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
                              color: Colors.white.withOpacity(0.2),
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
                          'Glassmorphism Cards',
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
                    child: ListView(
                      padding: const EdgeInsets.all(16),
                      children: [
                        _buildGlassmorphismCard(
                          title: 'Premium Card',
                          subtitle: 'Exclusive benefits',
                          icon: Icons.diamond,
                          color: Colors.purple,
                          delay: 0,
                        ),
                        _buildGlassmorphismCard(
                          title: 'Travel Card',
                          subtitle: 'Explore the world',
                          icon: Icons.flight,
                          color: Colors.blue,
                          delay: 200,
                        ),
                        _buildGlassmorphismCard(
                          title: 'Music Card',
                          subtitle: 'Unlimited streaming',
                          icon: Icons.music_note,
                          color: Colors.pink,
                          delay: 400,
                        ),
                        _buildGlassmorphismCard(
                          title: 'Fitness Card',
                          subtitle: 'Stay healthy',
                          icon: Icons.fitness_center,
                          color: Colors.green,
                          delay: 600,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGlassmorphismCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required int delay,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white.withOpacity(0.1),
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            color.withOpacity(0.8),
                            color.withOpacity(0.4),
                          ],
                        ),
                      ),
                      child: Icon(icon, color: Colors.white, size: 32),
                    )
                    .animate(delay: Duration(milliseconds: delay))
                    .scale(begin: const Offset(0, 0), end: const Offset(1, 1))
                    .then()
                    .shake(hz: 4),

                const SizedBox(width: 20),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                            title,
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          )
                          .animate(delay: Duration(milliseconds: delay + 100))
                          .fadeIn(duration: 600.ms)
                          .slideX(begin: 0.3),

                      const SizedBox(height: 4),

                      Text(
                            subtitle,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.white70,
                            ),
                          )
                          .animate(delay: Duration(milliseconds: delay + 200))
                          .fadeIn(duration: 600.ms)
                          .slideX(begin: 0.3),
                    ],
                  ),
                ),

                Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white.withOpacity(0.7),
                      size: 20,
                    )
                    .animate(delay: Duration(milliseconds: delay + 300))
                    .fadeIn(duration: 600.ms)
                    .slideX(begin: 0.3),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
