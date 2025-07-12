import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';

class LanguageLearningScreen extends StatefulWidget {
  const LanguageLearningScreen({super.key});

  @override
  State<LanguageLearningScreen> createState() => _LanguageLearningScreenState();
}

class _LanguageLearningScreenState extends State<LanguageLearningScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _pulseController;
  final int _selectedLesson = 0;
  final int _currentStreak = 7;
  final double _dailyProgress = 0.75;

  final List<Map<String, dynamic>> _lessons = [
    {
      'id': '1',
      'title': 'Basic Greetings',
      'subtitle': 'Learn common greetings',
      'difficulty': 'Beginner',
      'duration': '15 min',
      'progress': 1.0,
      'isCompleted': true,
      'icon': Icons.waving_hand,
      'color': Colors.green,
    },
    {
      'id': '2',
      'title': 'Numbers & Counting',
      'subtitle': 'Master numbers 1-100',
      'difficulty': 'Beginner',
      'duration': '20 min',
      'progress': 0.8,
      'isCompleted': false,
      'icon': Icons.numbers,
      'color': Colors.blue,
    },
    {
      'id': '3',
      'title': 'Food & Dining',
      'subtitle': 'Order food confidently',
      'difficulty': 'Intermediate',
      'duration': '25 min',
      'progress': 0.6,
      'isCompleted': false,
      'icon': Icons.restaurant,
      'color': Colors.orange,
    },
    {
      'id': '4',
      'title': 'Travel Phrases',
      'subtitle': 'Navigate new places',
      'difficulty': 'Intermediate',
      'duration': '30 min',
      'progress': 0.3,
      'isCompleted': false,
      'icon': Icons.flight,
      'color': Colors.purple,
    },
    {
      'id': '5',
      'title': 'Business Conversations',
      'subtitle': 'Professional communication',
      'difficulty': 'Advanced',
      'duration': '35 min',
      'progress': 0.0,
      'isCompleted': false,
      'icon': Icons.business,
      'color': Colors.red,
    },
  ];

  final List<Map<String, dynamic>> _vocabulary = [
    {
      'word': 'Bonjour',
      'translation': 'Hello',
      'category': 'Greetings',
      'isLearned': true,
    },
    {
      'word': 'Merci',
      'translation': 'Thank you',
      'category': 'Politeness',
      'isLearned': true,
    },
    {
      'word': 'Au revoir',
      'translation': 'Goodbye',
      'category': 'Greetings',
      'isLearned': true,
    },
    {
      'word': 'S\'il vous plaît',
      'translation': 'Please',
      'category': 'Politeness',
      'isLearned': false,
    },
    {
      'word': 'Excusez-moi',
      'translation': 'Excuse me',
      'category': 'Politeness',
      'isLearned': false,
    },
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    _controller.forward();
    _pulseController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    _pulseController.dispose();
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
              const Color(0xFF0F172A),
              const Color(0xFF1E293B),
              const Color(0xFF334155),
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
                            'Language Learning',
                            style: GoogleFonts.poppins(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Master French with AI',
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
                        color: Colors.blue.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.blue.withOpacity(0.3)),
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
                            '$_currentStreak',
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

              // Progress Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withOpacity(0.2)),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Today\'s Goal',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            '${(_dailyProgress * 100).toInt()}%',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      LinearProgressIndicator(
                        value: _dailyProgress,
                        backgroundColor: Colors.white.withOpacity(0.1),
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          Colors.blue,
                        ),
                        minHeight: 8,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          _buildStatItem('XP Today', '450', Icons.star),
                          const SizedBox(width: 24),
                          _buildStatItem('Lessons', '3/5', Icons.school),
                          const SizedBox(width: 24),
                          _buildStatItem('Words', '12/20', Icons.translate),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Lessons Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  children: [
                    Text(
                      'Lessons',
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

              // Lessons List
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  itemCount: _lessons.length,
                  itemBuilder: (context, index) {
                    return _buildLessonCard(_lessons[index], index);
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

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: Colors.blue, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            label,
            style: GoogleFonts.poppins(fontSize: 12, color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget _buildLessonCard(Map<String, dynamic> lesson, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: lesson['isCompleted']
              ? lesson['color'].withOpacity(0.5)
              : Colors.white.withOpacity(0.2),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: lesson['color'].withOpacity(0.2),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(lesson['icon'], color: lesson['color'], size: 30),
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
                        lesson['title'],
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    if (lesson['isCompleted'])
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.check,
                          color: Colors.green,
                          size: 16,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  lesson['subtitle'],
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
                        color: _getDifficultyColor(
                          lesson['difficulty'],
                        ).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        lesson['difficulty'],
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: _getDifficultyColor(lesson['difficulty']),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(Icons.access_time, color: Colors.white54, size: 14),
                    const SizedBox(width: 4),
                    Text(
                      lesson['duration'],
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.white54,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                LinearProgressIndicator(
                  value: lesson['progress'],
                  backgroundColor: Colors.white.withOpacity(0.1),
                  valueColor: AlwaysStoppedAnimation<Color>(lesson['color']),
                  minHeight: 4,
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: lesson['isCompleted']
                  ? lesson['color'].withOpacity(0.2)
                  : Colors.blue.withOpacity(0.2),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: lesson['isCompleted'] ? lesson['color'] : Colors.blue,
              ),
            ),
            child: Icon(
              lesson['isCompleted'] ? Icons.play_arrow : Icons.lock,
              color: lesson['isCompleted'] ? lesson['color'] : Colors.blue,
              size: 24,
            ),
          ),
        ],
      ),
    ).animate(delay: (index * 100).ms).fadeIn().slideX(begin: 0.3);
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case 'Beginner':
        return Colors.green;
      case 'Intermediate':
        return Colors.orange;
      case 'Advanced':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
