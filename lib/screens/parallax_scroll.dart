import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

class ParallaxScrollScreen extends StatefulWidget {
  const ParallaxScrollScreen({super.key});

  @override
  State<ParallaxScrollScreen> createState() => _ParallaxScrollScreenState();
}

class _ParallaxScrollScreenState extends State<ParallaxScrollScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          // App bar
          SliverAppBar(
            expandedHeight: 200,
            floating: false,
            pinned: true,
            backgroundColor: const Color(0xFF0F172A),
            leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white.withOpacity(0.1),
                ),
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: 16,
                ),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Parallax Scroll',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      const Color(0xFF8B5CF6),
                      const Color(0xFF6366F1),
                      const Color(0xFF06B6D4),
                    ],
                  ),
                ),
                child: Stack(
                  children: [
                    // Background elements
                    Positioned(
                      top: 50,
                      left: 50,
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.1),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 100,
                      right: 30,
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.1),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildParallaxCard(
                    title: 'Mountain View',
                    subtitle: 'Breathtaking landscapes',
                    image:
                        'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=400',
                    delay: 0,
                  ),
                  _buildParallaxCard(
                    title: 'Ocean Waves',
                    subtitle: 'Serene blue waters',
                    image:
                        'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=400',
                    delay: 200,
                  ),
                  _buildParallaxCard(
                    title: 'Forest Path',
                    subtitle: 'Nature\'s tranquility',
                    image:
                        'https://images.unsplash.com/photo-1441974231531-c6227db76b6e?w=400',
                    delay: 400,
                  ),
                  _buildParallaxCard(
                    title: 'City Lights',
                    subtitle: 'Urban nightscape',
                    image:
                        'https://images.unsplash.com/photo-1519501025264-65ba15a82390?w=400',
                    delay: 600,
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildParallaxCard({
    required String title,
    required String subtitle,
    required String image,
    required int delay,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            // Background image with parallax effect
            Positioned.fill(
              child: Image.network(
                image,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          const Color(0xFF8B5CF6),
                          const Color(0xFF6366F1),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // Gradient overlay
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                  ),
                ),
              ),
            ),

            // Content
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                        title,
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      )
                      .animate(delay: Duration(milliseconds: delay))
                      .fadeIn(duration: 600.ms)
                      .slideX(begin: 0.3),

                  const SizedBox(height: 4),

                  Text(
                        subtitle,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                      )
                      .animate(delay: Duration(milliseconds: delay + 100))
                      .fadeIn(duration: 600.ms)
                      .slideX(begin: 0.3),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
