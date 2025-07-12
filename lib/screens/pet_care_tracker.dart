import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';

class PetCareTrackerScreen extends StatefulWidget {
  const PetCareTrackerScreen({super.key});

  @override
  State<PetCareTrackerScreen> createState() => _PetCareTrackerScreenState();
}

class _PetCareTrackerScreenState extends State<PetCareTrackerScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  int _selectedPet = 0;
  int _selectedTab = 0;

  final List<Map<String, dynamic>> _pets = [
    {
      'id': '1',
      'name': 'Buddy',
      'type': 'Dog',
      'breed': 'Golden Retriever',
      'age': '3 years',
      'weight': '28 kg',
      'image': 'https://images.unsplash.com/photo-1552053831-71594a27632d',
      'color': Colors.orange,
      'healthScore': 95,
      'lastFed': '2 hours ago',
      'nextVaccination': '2024-03-15',
    },
    {
      'id': '2',
      'name': 'Whiskers',
      'type': 'Cat',
      'breed': 'Persian',
      'age': '2 years',
      'weight': '4.5 kg',
      'image': 'https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba',
      'color': Colors.purple,
      'healthScore': 88,
      'lastFed': '4 hours ago',
      'nextVaccination': '2024-02-20',
    },
  ];

  final List<Map<String, dynamic>> _activities = [
    {
      'id': '1',
      'title': 'Morning Walk',
      'time': '7:00 AM',
      'duration': '30 min',
      'type': 'Exercise',
      'icon': Icons.directions_walk,
      'color': Colors.green,
      'isCompleted': true,
    },
    {
      'id': '2',
      'title': 'Breakfast',
      'time': '8:00 AM',
      'duration': '15 min',
      'type': 'Feeding',
      'icon': Icons.restaurant,
      'color': Colors.orange,
      'isCompleted': true,
    },
    {
      'id': '3',
      'title': 'Play Time',
      'time': '10:00 AM',
      'duration': '20 min',
      'type': 'Activity',
      'icon': Icons.toys,
      'color': Colors.blue,
      'isCompleted': false,
    },
    {
      'id': '4',
      'title': 'Dinner',
      'time': '6:00 PM',
      'duration': '15 min',
      'type': 'Feeding',
      'icon': Icons.restaurant,
      'color': Colors.orange,
      'isCompleted': false,
    },
    {
      'id': '5',
      'title': 'Evening Walk',
      'time': '7:30 PM',
      'duration': '25 min',
      'type': 'Exercise',
      'icon': Icons.directions_walk,
      'color': Colors.green,
      'isCompleted': false,
    },
  ];

  final List<Map<String, dynamic>> _healthRecords = [
    {
      'id': '1',
      'title': 'Annual Checkup',
      'date': '2024-01-15',
      'vet': 'Dr. Sarah Johnson',
      'notes': 'All vaccinations up to date, healthy weight',
      'type': 'Checkup',
      'color': Colors.green,
    },
    {
      'id': '2',
      'title': 'Dental Cleaning',
      'date': '2024-01-10',
      'vet': 'Dr. Mike Chen',
      'notes': 'Teeth cleaned, no issues found',
      'type': 'Dental',
      'color': Colors.blue,
    },
    {
      'id': '3',
      'title': 'Vaccination',
      'date': '2024-01-05',
      'vet': 'Dr. Sarah Johnson',
      'notes': 'Rabies and DHPP vaccines administered',
      'type': 'Vaccination',
      'color': Colors.purple,
    },
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _controller.forward();
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
                            'Pet Care Tracker',
                            style: GoogleFonts.poppins(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Keep your pets healthy',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        // Add new pet
                      },
                      icon: const Icon(Icons.add, color: Colors.white),
                    ),
                  ],
                ),
              ),

              // Pet Selector
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: SizedBox(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _pets.length,
                    itemBuilder: (context, index) {
                      return _buildPetCard(_pets[index], index);
                    },
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Quick Stats
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  children: [
                    Expanded(
                      child: _buildStatCard(
                        'Health Score',
                        '${_pets[_selectedPet]['healthScore']}%',
                        Icons.favorite,
                        Colors.green,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildStatCard(
                        'Last Fed',
                        _pets[_selectedPet]['lastFed'],
                        Icons.restaurant,
                        Colors.orange,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildStatCard(
                        'Weight',
                        _pets[_selectedPet]['weight'],
                        Icons.monitor_weight,
                        Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Tab Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white.withOpacity(0.2)),
                  ),
                  child: Row(
                    children: ['Today', 'Health', 'Activities']
                        .asMap()
                        .entries
                        .map((entry) {
                          final index = entry.key;
                          final title = entry.value;
                          final isSelected = _selectedTab == index;
                          return Expanded(
                            child: GestureDetector(
                              onTap: () => setState(() => _selectedTab = index),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? Colors.white.withOpacity(0.2)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  title,
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: isSelected
                                        ? FontWeight.w600
                                        : FontWeight.w400,
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.white70,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          );
                        })
                        .toList(),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Content based on selected tab
              Expanded(
                child: _selectedTab == 0
                    ? _buildTodaySchedule()
                    : _selectedTab == 1
                    ? _buildHealthRecords()
                    : _buildActivities(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPetCard(Map<String, dynamic> pet, int index) {
    final isSelected = _selectedPet == index;
    return Container(
          width: 120,
          margin: const EdgeInsets.only(right: 16),
          child: GestureDetector(
            onTap: () => setState(() => _selectedPet = index),
            child: Column(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: pet['color'].withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isSelected
                          ? pet['color']
                          : Colors.white.withOpacity(0.2),
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: const Icon(Icons.pets, color: Colors.white, size: 40),
                ),
                const SizedBox(height: 8),
                Text(
                  pet['name'],
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    color: isSelected ? pet['color'] : Colors.white,
                  ),
                ),
                Text(
                  pet['type'],
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        )
        .animate(delay: (index * 100).ms)
        .fadeIn()
        .scale(begin: const Offset(0.8, 0.8));
  }

  Widget _buildStatCard(
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: Column(
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
      ),
    ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.3);
  }

  Widget _buildTodaySchedule() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      itemCount: _activities.length,
      itemBuilder: (context, index) {
        return _buildActivityCard(_activities[index], index);
      },
    );
  }

  Widget _buildActivityCard(Map<String, dynamic> activity, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: activity['isCompleted']
              ? activity['color'].withOpacity(0.5)
              : Colors.white.withOpacity(0.2),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: activity['color'].withOpacity(0.2),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(activity['icon'], color: activity['color'], size: 24),
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
                        activity['title'],
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    if (activity['isCompleted'])
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
                  '${activity['time']} • ${activity['duration']}',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: activity['color'].withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    activity['type'],
                    style: GoogleFonts.poppins(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: activity['color'],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: activity['isCompleted']
                  ? Colors.green.withOpacity(0.2)
                  : activity['color'].withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: activity['isCompleted']
                    ? Colors.green
                    : activity['color'],
              ),
            ),
            child: Icon(
              activity['isCompleted'] ? Icons.check : Icons.play_arrow,
              color: activity['isCompleted'] ? Colors.green : activity['color'],
              size: 20,
            ),
          ),
        ],
      ),
    ).animate(delay: (index * 100).ms).fadeIn().slideX(begin: 0.3);
  }

  Widget _buildHealthRecords() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      itemCount: _healthRecords.length,
      itemBuilder: (context, index) {
        return _buildHealthCard(_healthRecords[index], index);
      },
    );
  }

  Widget _buildHealthCard(Map<String, dynamic> record, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: record['color'].withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.medical_services,
                  color: record['color'],
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      record['title'],
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      record['date'],
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: record['color'].withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  record['type'],
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: record['color'],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Vet: ${record['vet']}',
            style: GoogleFonts.poppins(fontSize: 14, color: Colors.white70),
          ),
          const SizedBox(height: 8),
          Text(
            record['notes'],
            style: GoogleFonts.poppins(fontSize: 14, color: Colors.white70),
          ),
        ],
      ),
    ).animate(delay: (index * 100).ms).fadeIn().slideX(begin: 0.3);
  }

  Widget _buildActivities() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.fitness_center,
            size: 80,
            color: Colors.white.withOpacity(0.3),
          ),
          const SizedBox(height: 16),
          Text(
            'Activity History',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Track your pet\'s daily activities',
            style: GoogleFonts.poppins(fontSize: 14, color: Colors.white70),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
