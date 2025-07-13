import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';

class MorphingShapesScreen extends StatefulWidget {
  const MorphingShapesScreen({super.key});

  @override
  State<MorphingShapesScreen> createState() => _MorphingShapesScreenState();
}

class _MorphingShapesScreenState extends State<MorphingShapesScreen>
    with TickerProviderStateMixin {
  late AnimationController _morphController;
  late AnimationController _rotationController;
  late Animation<double> _morphAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _morphController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );
    _rotationController = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    );

    _morphAnimation = CurvedAnimation(
      parent: _morphController,
      curve: Curves.easeInOut,
    );
    _rotationAnimation = CurvedAnimation(
      parent: _rotationController,
      curve: Curves.linear,
    );

    _morphController.repeat(reverse: true);
    _rotationController.repeat();
  }

  @override
  void dispose() {
    _morphController.dispose();
    _rotationController.dispose();
    super.dispose();
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
                      'Morphing Shapes',
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
                    _buildMorphingShape(),
                    _buildRotatingShape(),
                    _buildPulsingShape(),
                    _buildWaveShape(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMorphingShape() {
    return AnimatedBuilder(
      animation: _morphAnimation,
      builder: (context, child) {
        return Container(
          margin: const EdgeInsets.only(bottom: 20),
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [const Color(0xFF06B6D4), const Color(0xFF8B5CF6)],
            ),
          ),
          child: Center(
            child: CustomPaint(
              painter: MorphingShapePainter(
                animation: _morphAnimation,
                color: Colors.white,
              ),
              size: const Size(100, 100),
            ),
          ),
        ).animate(delay: 0.ms).fadeIn(duration: 600.ms).slideY(begin: 0.3);
      },
    );
  }

  Widget _buildRotatingShape() {
    return AnimatedBuilder(
      animation: _rotationAnimation,
      builder: (context, child) {
        return Container(
          margin: const EdgeInsets.only(bottom: 20),
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [const Color(0xFFF59E0B), const Color(0xFFEF4444)],
            ),
          ),
          child: Center(
            child: Transform.rotate(
              angle: _rotationAnimation.value * 2 * pi,
              child: CustomPaint(
                painter: StarPainter(color: Colors.white, points: 5),
                size: const Size(80, 80),
              ),
            ),
          ),
        ).animate(delay: 300.ms).fadeIn(duration: 600.ms).slideY(begin: 0.3);
      },
    );
  }

  Widget _buildPulsingShape() {
    return AnimatedBuilder(
      animation: _morphAnimation,
      builder: (context, child) {
        return Container(
          margin: const EdgeInsets.only(bottom: 20),
          height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [const Color(0xFF10B981), const Color(0xFF84CC16)],
            ),
          ),
          child: Center(
            child: Transform.scale(
              scale: 0.8 + (0.4 * _morphAnimation.value),
              child: CustomPaint(
                painter: HexagonPainter(color: Colors.white),
                size: const Size(60, 60),
              ),
            ),
          ),
        ).animate(delay: 600.ms).fadeIn(duration: 600.ms).slideY(begin: 0.3);
      },
    );
  }

  Widget _buildWaveShape() {
    return AnimatedBuilder(
      animation: _morphAnimation,
      builder: (context, child) {
        return Container(
          margin: const EdgeInsets.only(bottom: 20),
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [const Color(0xFFEC4899), const Color(0xFF8B5CF6)],
            ),
          ),
          child: CustomPaint(
            painter: WaveShapePainter(
              animation: _morphAnimation,
              color: Colors.white.withOpacity(0.3),
            ),
            size: const Size(double.infinity, 100),
          ),
        ).animate(delay: 900.ms).fadeIn(duration: 600.ms).slideY(begin: 0.3);
      },
    );
  }
}

class MorphingShapePainter extends CustomPainter {
  final Animation<double> animation;
  final Color color;

  MorphingShapePainter({required this.animation, required this.color})
    : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 3;

    // Morph between circle and square
    final morphValue = animation.value;
    final sides = 4 + (morphValue * 4).round(); // 4 to 8 sides

    for (int i = 0; i < sides; i++) {
      final angle = (i * 2 * pi / sides) + (morphValue * pi / 2);
      final x = center.dx + radius * cos(angle);
      final y = center.dy + radius * sin(angle);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(MorphingShapePainter oldDelegate) => true;
}

class StarPainter extends CustomPainter {
  final Color color;
  final int points;

  StarPainter({required this.color, required this.points});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    final center = Offset(size.width / 2, size.height / 2);
    final outerRadius = size.width / 2;
    final innerRadius = outerRadius * 0.4;

    for (int i = 0; i < points * 2; i++) {
      final angle = (i * pi / points);
      final radius = i.isEven ? outerRadius : innerRadius;
      final x = center.dx + radius * cos(angle);
      final y = center.dy + radius * sin(angle);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(StarPainter oldDelegate) => true;
}

class HexagonPainter extends CustomPainter {
  final Color color;

  HexagonPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    for (int i = 0; i < 6; i++) {
      final angle = (i * pi / 3);
      final x = center.dx + radius * cos(angle);
      final y = center.dy + radius * sin(angle);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(HexagonPainter oldDelegate) => true;
}

class WaveShapePainter extends CustomPainter {
  final Animation<double> animation;
  final Color color;

  WaveShapePainter({required this.animation, required this.color})
    : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, size.height);

    for (double i = 0; i <= size.width; i++) {
      path.lineTo(
        i,
        size.height -
            30 * (0.5 + 0.5 * sin(animation.value * 2 * pi + i * 0.02)),
      );
    }

    path.lineTo(size.width, size.height);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(WaveShapePainter oldDelegate) => true;
}
