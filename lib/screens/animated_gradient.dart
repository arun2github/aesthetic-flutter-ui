import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';

class AnimatedGradientScreen extends StatefulWidget {
  const AnimatedGradientScreen({super.key});

  @override
  State<AnimatedGradientScreen> createState() => _AnimatedGradientScreenState();
}

class _AnimatedGradientScreenState extends State<AnimatedGradientScreen>
    with TickerProviderStateMixin {
  late AnimationController _gradientController;
  late AnimationController _pulseController;
  late Animation<double> _gradientAnimation;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _gradientController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _gradientAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _gradientController, curve: Curves.easeInOut),
    );
    _pulseAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _gradientController.repeat();
    _pulseController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _gradientController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _gradientAnimation,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.lerp(
                    const Color(0xFF667eea),
                    const Color(0xFF764ba2),
                    _gradientAnimation.value,
                  )!,
                  Color.lerp(
                    const Color(0xFFf093fb),
                    const Color(0xFFf5576c),
                    _gradientAnimation.value,
                  )!,
                  Color.lerp(
                    const Color(0xFF4facfe),
                    const Color(0xFF00f2fe),
                    _gradientAnimation.value,
                  )!,
                ],
                stops: [0.0, 0.5, 1.0],
              ),
            ),
            child: SafeArea(
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
                          'Animated Gradient',
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
                        _buildGradientCard(
                          title: 'Premium Features',
                          subtitle: 'Unlock amazing possibilities',
                          icon: Icons.star,
                          delay: 0,
                        ),
                        _buildPulsingCard(),
                        _buildMorphingCard(),
                        _buildWaveCard(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildGradientCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required int delay,
  }) {
    return AnimatedBuilder(
      animation: _gradientAnimation,
      builder: (context, child) {
        return Container(
          margin: const EdgeInsets.only(bottom: 20),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.lerp(
                  Colors.white.withOpacity(0.2),
                  Colors.white.withOpacity(0.3),
                  _gradientAnimation.value,
                )!,
                Color.lerp(
                  Colors.white.withOpacity(0.1),
                  Colors.white.withOpacity(0.2),
                  _gradientAnimation.value,
                )!,
              ],
            ),
            border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
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
                          Color.lerp(
                            const Color(0xFF667eea),
                            const Color(0xFF764ba2),
                            _gradientAnimation.value,
                          )!,
                          Color.lerp(
                            const Color(0xFFf093fb),
                            const Color(0xFFf5576c),
                            _gradientAnimation.value,
                          )!,
                        ],
                      ),
                    ),
                    child: Icon(icon, color: Colors.white, size: 32),
                  )
                  .animate(delay: Duration(milliseconds: delay))
                  .scale(begin: const Offset(0, 0), end: const Offset(1, 1)),

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
            ],
          ),
        );
      },
    );
  }

  Widget _buildPulsingCard() {
    return AnimatedBuilder(
      animation: _pulseAnimation,
      builder: (context, child) {
        return Container(
          margin: const EdgeInsets.only(bottom: 20),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white.withOpacity(0.1),
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.1 * _pulseAnimation.value),
                blurRadius: 20 * _pulseAnimation.value,
                spreadRadius: 5 * _pulseAnimation.value,
              ),
            ],
          ),
          child: Column(
            children: [
              Icon(
                Icons.favorite,
                size: 48 + (20 * _pulseAnimation.value),
                color: Color.lerp(
                  Colors.white,
                  const Color(0xFFf5576c),
                  _pulseAnimation.value,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Pulsing Effect',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ).animate(delay: 300.ms).fadeIn(duration: 600.ms).slideY(begin: 0.3);
      },
    );
  }

  Widget _buildMorphingCard() {
    return AnimatedBuilder(
      animation: _gradientAnimation,
      builder: (context, child) {
        return Container(
          margin: const EdgeInsets.only(bottom: 20),
          height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.lerp(
                  const Color(0xFF4facfe),
                  const Color(0xFF00f2fe),
                  _gradientAnimation.value,
                )!,
                Color.lerp(
                  const Color(0xFF43e97b),
                  const Color(0xFF38f9d7),
                  _gradientAnimation.value,
                )!,
              ],
            ),
          ),
          child: Center(
            child: Text(
              'Morphing Colors',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ).animate(delay: 600.ms).fadeIn(duration: 600.ms).slideY(begin: 0.3);
      },
    );
  }

  Widget _buildWaveCard() {
    return AnimatedBuilder(
      animation: _gradientAnimation,
      builder: (context, child) {
        return Container(
          margin: const EdgeInsets.only(bottom: 20),
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.lerp(
                  const Color(0xFFfa709a),
                  const Color(0xFFfee140),
                  _gradientAnimation.value,
                )!,
                Color.lerp(
                  const Color(0xFFa8edea),
                  const Color(0xFFfed6e3),
                  _gradientAnimation.value,
                )!,
              ],
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: CustomPaint(
                  painter: WavePainter(animation: _gradientAnimation),
                  size: const Size(double.infinity, 50),
                ),
              ),
              Center(
                child: Text(
                  'Wave Animation',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ).animate(delay: 900.ms).fadeIn(duration: 600.ms).slideY(begin: 0.3);
      },
    );
  }
}

class WavePainter extends CustomPainter {
  final Animation<double> animation;

  WavePainter({required this.animation}) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.3)
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, size.height);

    for (double i = 0; i <= size.width; i++) {
      path.lineTo(
        i,
        size.height -
            20 *
                (1 + animation.value) *
                (0.5 + 0.5 * sin(animation.value * 2 * pi + i * 0.02)),
      );
    }

    path.lineTo(size.width, size.height);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(WavePainter oldDelegate) => true;
}
