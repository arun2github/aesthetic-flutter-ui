import 'package:flutter/material.dart';
import 'dart:math';
import 'package:google_fonts/google_fonts.dart';

class ParticleBackgroundScreen extends StatefulWidget {
  const ParticleBackgroundScreen({super.key});

  @override
  State<ParticleBackgroundScreen> createState() =>
      _ParticleBackgroundScreenState();
}

class _ParticleBackgroundScreenState extends State<ParticleBackgroundScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<_Particle> _particles = [];
  final int _numParticles = 60;
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
    for (int i = 0; i < _numParticles; i++) {
      _particles.add(
        _Particle(
          x: _random.nextDouble(),
          y: _random.nextDouble(),
          radius: 2 + _random.nextDouble() * 4,
          dx: (_random.nextDouble() - 0.5) * 0.002,
          dy: (_random.nextDouble() - 0.5) * 0.002,
          color: Colors.primaries[_random.nextInt(Colors.primaries.length)]
              .withOpacity(0.7),
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E293B),
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return CustomPaint(
                painter: _ParticlePainter(_particles, _controller.value),
                child: Container(),
              );
            },
          ),
          SafeArea(
            child: Column(
              children: [
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
                        'Particle Background',
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Particle {
  double x, y, radius, dx, dy;
  Color color;
  _Particle({
    required this.x,
    required this.y,
    required this.radius,
    required this.dx,
    required this.dy,
    required this.color,
  });
}

class _ParticlePainter extends CustomPainter {
  final List<_Particle> particles;
  final double progress;
  _ParticlePainter(this.particles, this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    for (final p in particles) {
      p.x += p.dx;
      p.y += p.dy;
      if (p.x < 0 || p.x > 1) p.dx = -p.dx;
      if (p.y < 0 || p.y > 1) p.dy = -p.dy;
      final offset = Offset(p.x * size.width, p.y * size.height);
      final paint = Paint()..color = p.color;
      canvas.drawCircle(offset, p.radius, paint);
    }
  }

  @override
  bool shouldRepaint(_ParticlePainter oldDelegate) => true;
}
