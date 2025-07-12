import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';

class MeditationAppScreen extends StatefulWidget {
  const MeditationAppScreen({super.key});

  @override
  State<MeditationAppScreen> createState() => _MeditationAppScreenState();
}

class _MeditationAppScreenState extends State<MeditationAppScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _breathingController;
  late AnimationController _pulseController;
  bool _isBreathing = false;
  final int _selectedSession = 0;
  final int _totalMinutes = 1240;
  final int _currentStreak = 12;

  final List<Map<String, dynamic>> _sessions = [
    {
      'id': '1',
      'title': 'Morning Calm',
      'subtitle': 'Start your day with peace',
      'duration': '10 min',
      'category': 'Mindfulness',
      'isPremium': false,
      'icon': Icons.wb_sunny,
      'color': Colors.orange,
      'description': 'Gentle breathing exercises to awaken your mind and body.',
    },
    {
      'id': '2',
      'title': 'Stress Relief',
      'subtitle': 'Release tension and anxiety',
      'duration': '15 min',
      'category': 'Relaxation',
      'isPremium': false,
      'icon': Icons.self_improvement,
      'color': Colors.green,
      'description': 'Progressive muscle relaxation to melt away stress.',
    },
    {
      'id': '3',
      'title': 'Deep Sleep',
      'subtitle': 'Prepare for restful sleep',
      'duration': '20 min',
      'category': 'Sleep',
      'isPremium': true,
      'icon': Icons.bedtime,
      'color': Colors.indigo,
      'description': 'Soothing sounds and guided imagery for better sleep.',
    },
    {
      'id': '4',
      'title': 'Focus & Clarity',
      'subtitle': 'Enhance concentration',
      'duration': '12 min',
      'category': 'Focus',
      'isPremium': false,
      'icon': Icons.psychology,
      'color': Colors.blue,
      'description': 'Mindfulness techniques to improve focus and clarity.',
    },
    {
      'id': '5',
      'title': 'Loving Kindness',
      'subtitle': 'Cultivate compassion',
      'duration': '18 min',
      'category': 'Compassion',
      'isPremium': true,
      'icon': Icons.favorite,
      'color': Colors.pink,
      'description': 'Metta meditation to develop love and kindness.',
    },
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    _breathingController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _controller.forward();
    _pulseController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    _breathingController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  void _startBreathing() {
    setState(() => _isBreathing = true);
    _breathingController.repeat(reverse: true);
  }

  void _stopBreathing() {
    setState(() => _isBreathing = false);
    _breathingController.stop();
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
              const Color(0xFF1A1A2E),
              const Color(0xFF16213E),
              const Color(0xFF0F3460),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Meditation',
                            style: GoogleFonts.poppins(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Find your inner peace',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.green.withOpacity(0.3),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.local_fire_department,
                            color: Colors.orange,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '$_currentStreak days',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Breathing Exercise
              if (_isBreathing) _buildBreathingExercise(),

              // Stats Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withOpacity(0.2)),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: _buildStatItem(
                          'Total Minutes',
                          '${(_totalMinutes / 60).round()}h ${_totalMinutes % 60}m',
                          Icons.timer,
                          Colors.blue,
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 50,
                        color: Colors.white.withOpacity(0.2),
                      ),
                      Expanded(
                        child: _buildStatItem(
                          'This Week',
                          '45 min',
                          Icons.calendar_today,
                          Colors.green,
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 50,
                        color: Colors.white.withOpacity(0.2),
                      ),
                      Expanded(
                        child: _buildStatItem(
                          'Sessions',
                          '8',
                          Icons.self_improvement,
                          Colors.purple,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Quick Start Button
              if (!_isBreathing)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: GestureDetector(
                    onTap: _startBreathing,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.blue.withOpacity(0.8),
                            Colors.purple.withOpacity(0.8),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.3),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: const Icon(
                              Icons.air,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Quick Breathing',
                                  style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  'Take a moment to breathe',
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: Colors.white70,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(
                            Icons.play_arrow,
                            color: Colors.white,
                            size: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

              const SizedBox(height: 24),

              // Sessions Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  children: [
                    Text(
                      'Guided Sessions',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'View All',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Sessions List
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  itemCount: _sessions.length,
                  itemBuilder: (context, index) {
                    return _buildSessionCard(_sessions[index], index);
                  },
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBreathingExercise() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.blue.withOpacity(0.3),
            Colors.purple.withOpacity(0.3),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Text(
            'Breathe',
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          AnimatedBuilder(
            animation: _breathingController,
            builder: (context, child) {
              return Container(
                width: 120 + (_breathingController.value * 80),
                height: 120 + (_breathingController.value * 80),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white.withOpacity(0.3),
                    width: 2,
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.air,
                    color: Colors.white,
                    size: 40 + (_breathingController.value * 20),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          Text(
            _breathingController.value > 0.5 ? 'Inhale' : 'Exhale',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: _stopBreathing,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.red.withOpacity(0.3)),
              ),
              child: Text(
                'Stop',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.red,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Column(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(height: 8),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.poppins(fontSize: 12, color: Colors.white70),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildSessionCard(Map<String, dynamic> session, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: session['color'].withOpacity(0.2),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(session['icon'], color: session['color'], size: 30),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        session['title'],
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    if (session['isPremium'])
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.amber.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 16,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  session['subtitle'],
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: session['color'].withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        session['category'],
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: session['color'],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(Icons.access_time, color: Colors.white54, size: 14),
                    const SizedBox(width: 4),
                    Text(
                      session['duration'],
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.white54,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: session['color'].withOpacity(0.2),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: session['color']),
            ),
            child: Icon(Icons.play_arrow, color: session['color'], size: 24),
          ),
        ],
      ),
    ).animate(delay: (index * 100).ms).fadeIn().slideX(begin: 0.3);
  }
}
