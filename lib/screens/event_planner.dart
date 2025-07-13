import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';

class EventPlannerScreen extends StatefulWidget {
  const EventPlannerScreen({super.key});

  @override
  State<EventPlannerScreen> createState() => _EventPlannerScreenState();
}

class _EventPlannerScreenState extends State<EventPlannerScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  int _selectedTab = 0;
  final DateTime _selectedDate = DateTime.now();

  final List<Map<String, dynamic>> _events = [
    {
      'id': '1',
      'title': 'Team Meeting',
      'description': 'Weekly team sync and project updates',
      'date': DateTime.now().add(const Duration(days: 1)),
      'time': '10:00 AM',
      'duration': '1 hour',
      'location': 'Conference Room A',
      'attendees': ['John Doe', 'Jane Smith', 'Mike Johnson'],
      'category': 'Work',
      'color': Colors.blue,
      'isConfirmed': true,
    },
    {
      'id': '2',
      'title': 'Birthday Party',
      'description': 'Sarah\'s 25th birthday celebration',
      'date': DateTime.now().add(const Duration(days: 3)),
      'time': '7:00 PM',
      'duration': '3 hours',
      'location': 'The Grand Hotel',
      'attendees': ['Sarah', 'Alex', 'Emma', 'David', 'Lisa'],
      'category': 'Personal',
      'color': Colors.pink,
      'isConfirmed': true,
    },
    {
      'id': '3',
      'title': 'Client Presentation',
      'description': 'Present quarterly results to stakeholders',
      'date': DateTime.now().add(const Duration(days: 5)),
      'time': '2:00 PM',
      'duration': '2 hours',
      'location': 'Virtual Meeting',
      'attendees': ['Client Team', 'Marketing', 'Sales'],
      'category': 'Work',
      'color': Colors.green,
      'isConfirmed': false,
    },
    {
      'id': '4',
      'title': 'Dinner with Friends',
      'description': 'Catch up with old friends',
      'date': DateTime.now().add(const Duration(days: 7)),
      'time': '6:30 PM',
      'duration': '2 hours',
      'location': 'Italian Restaurant',
      'attendees': ['Tom', 'Jerry', 'Spike'],
      'category': 'Social',
      'color': Colors.orange,
      'isConfirmed': true,
    },
  ];

  final List<Map<String, dynamic>> _upcomingEvents = [
    {
      'id': '1',
      'title': 'Team Meeting',
      'date': 'Tomorrow',
      'time': '10:00 AM',
      'color': Colors.blue,
    },
    {
      'id': '2',
      'title': 'Birthday Party',
      'date': 'Dec 20',
      'time': '7:00 PM',
      'color': Colors.pink,
    },
    {
      'id': '3',
      'title': 'Client Presentation',
      'date': 'Dec 22',
      'time': '2:00 PM',
      'color': Colors.green,
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
          child: Padding(
            padding: const EdgeInsets.only(top: 12.0),
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
                              'Event Planner',
                              style: GoogleFonts.poppins(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'Organize your life',
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
                          // Add new event
                        },
                        icon: const Icon(Icons.add, color: Colors.white),
                      ),
                    ],
                  ),
                ),

                // Quick Stats
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          'Upcoming',
                          '${_events.where((e) => e['date'].isAfter(DateTime.now())).length}',
                          Icons.event,
                          Colors.blue,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildStatCard(
                          'This Week',
                          '3',
                          Icons.calendar_today,
                          Colors.green,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildStatCard(
                          'Pending',
                          '1',
                          Icons.pending,
                          Colors.orange,
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
                      children: ['Timeline', 'Calendar', 'Upcoming']
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
                      ? _buildTimeline()
                      : _selectedTab == 1
                      ? _buildCalendar()
                      : _buildUpcoming(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
              fontSize: 20,
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

  Widget _buildTimeline() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      itemCount: _events.length,
      itemBuilder: (context, index) {
        return _buildTimelineEvent(_events[index], index);
      },
    );
  }

  Widget _buildTimelineEvent(Map<String, dynamic> event, int index) {
    final isToday = event['date'].difference(DateTime.now()).inDays == 0;
    final isTomorrow = event['date'].difference(DateTime.now()).inDays == 1;

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          // Timeline line and dot
          Column(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: event['color'],
                  shape: BoxShape.circle,
                ),
              ),
              if (index < _events.length - 1)
                Container(
                  width: 2,
                  height: 60,
                  color: Colors.white.withOpacity(0.2),
                ),
            ],
          ),
          const SizedBox(width: 16),

          // Event card
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: event['color'].withOpacity(0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          event['title'],
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: event['color'].withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          event['category'],
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: event['color'],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    event['description'],
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(Icons.access_time, color: Colors.white54, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        '${event['time']} • ${event['duration']}',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.white54,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Icon(Icons.location_on, color: Colors.white54, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        event['location'],
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.white54,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Text(
                        isToday
                            ? 'Today'
                            : isTomorrow
                            ? 'Tomorrow'
                            : '${event['date'].day}/${event['date'].month}',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: event['color'],
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          ...event['attendees']
                              .take(3)
                              .map(
                                (attendee) => Container(
                                  margin: const EdgeInsets.only(right: 4),
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    color: event['color'].withOpacity(0.3),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Text(
                                      attendee
                                          .split(' ')
                                          .map((e) => e[0])
                                          .join(''),
                                      style: GoogleFonts.poppins(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: event['color'],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          if (event['attendees'].length > 3)
                            Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  '+${event['attendees'].length - 3}',
                                  style: GoogleFonts.poppins(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ).animate(delay: (index * 100).ms).fadeIn().slideX(begin: 0.3);
  }

  Widget _buildCalendar() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.calendar_month,
            size: 80,
            color: Colors.white.withOpacity(0.3),
          ),
          const SizedBox(height: 16),
          Text(
            'Calendar View',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Interactive calendar coming soon',
            style: GoogleFonts.poppins(fontSize: 14, color: Colors.white70),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildUpcoming() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      itemCount: _upcomingEvents.length,
      itemBuilder: (context, index) {
        return _buildUpcomingEvent(_upcomingEvents[index], index);
      },
    );
  }

  Widget _buildUpcomingEvent(Map<String, dynamic> event, int index) {
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
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: event['color'].withOpacity(0.2),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(Icons.event, color: event['color'], size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event['title'],
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${event['date']} • ${event['time']}',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: event['color'].withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: event['color']),
            ),
            child: Icon(
              Icons.arrow_forward_ios,
              color: event['color'],
              size: 16,
            ),
          ),
        ],
      ),
    ).animate(delay: (index * 100).ms).fadeIn().slideX(begin: 0.3);
  }
}
