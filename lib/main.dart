import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/glassmorphism_card.dart';
import 'screens/neumorphic_ui.dart';
import 'screens/animated_gradient.dart';
import 'screens/floating_action_menu.dart';
import 'screens/parallax_scroll.dart';
import 'screens/morphing_shapes.dart';
import 'screens/glassmorphism_navbar.dart';
import 'screens/animated_loading.dart';
import 'screens/particle_background.dart';
import 'screens/3d_card_effect.dart';
import 'screens/smart_home_dashboard.dart';
import 'screens/crypto_trading.dart';
import 'screens/fitness_tracker.dart';
import 'screens/food_delivery.dart';
import 'screens/travel_booking.dart';
import 'screens/ecommerce_store.dart';
import 'screens/social_media_feed.dart';
import 'screens/weather_app.dart';
import 'screens/task_manager.dart';
import 'screens/news_reader.dart';
import 'screens/photo_editor.dart';
import 'screens/language_learning.dart';
import 'screens/meditation_app.dart';
import 'screens/car_sharing.dart';
import 'screens/event_planner.dart';
import 'screens/recipe_finder.dart';
import 'screens/pet_care_tracker.dart';
// import 'screens/plant_care_app.dart';
import 'dart:ui';

void main() {
  runApp(const InstagramUIShowcase());
}

class InstagramUIShowcase extends StatelessWidget {
  const InstagramUIShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'Instagram UI Showcase',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6366F1),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final List<Map<String, dynamic>> uiTrends = [
    {
      'title': 'Glassmorphism Card',
      'description': 'Modern glass effect with blur and transparency',
      'icon': Icons.blur_on,
      'color': const Color(0xFF6366F1),
      'screen': const GlassmorphismCardScreen(),
    },
    {
      'title': 'Neumorphic UI',
      'description': 'Soft shadows and subtle depth effects',
      'icon': Icons.layers,
      'color': const Color(0xFF10B981),
      'screen': const NeumorphicUIScreen(),
    },
    {
      'title': 'Animated Gradient',
      'description': 'Dynamic color transitions and morphing',
      'icon': Icons.gradient,
      'color': const Color(0xFFF59E0B),
      'screen': const AnimatedGradientScreen(),
    },
    {
      'title': 'Floating Action Menu',
      'description': 'Expandable circular menu with animations',
      'icon': Icons.add_circle_outline,
      'color': const Color(0xFFEF4444),
      'screen': const FloatingActionMenuScreen(),
    },
    {
      'title': 'Parallax Scroll',
      'description': 'Layered scrolling with depth perception',
      'icon': Icons.view_in_ar,
      'color': const Color(0xFF8B5CF6),
      'screen': const ParallaxScrollScreen(),
    },
    {
      'title': 'Morphing Shapes',
      'description': 'Animated geometric transformations',
      'icon': Icons.shape_line,
      'color': const Color(0xFF06B6D4),
      'screen': const MorphingShapesScreen(),
    },
    {
      'title': 'Glassmorphism Navbar',
      'description': 'Transparent navigation with blur effects',
      'icon': Icons.navigation,
      'color': const Color(0xFFEC4899),
      'screen': const GlassmorphismNavbarScreen(),
    },
    {
      'title': 'Animated Loading',
      'description': 'Creative loading animations and skeletons',
      'icon': Icons.hourglass_empty,
      'color': const Color(0xFF84CC16),
      'screen': const AnimatedLoadingScreen(),
    },
    {
      'title': 'Particle Background',
      'description': 'Interactive floating particles',
      'icon': Icons.grain,
      'color': const Color(0xFFF97316),
      'screen': const ParticleBackgroundScreen(),
    },
    {
      'title': '3D Card Effect',
      'description': 'Perspective transformations and depth',
      'icon': Icons.view_in_ar,
      'color': const Color(0xFF7C3AED),
      'screen': const ThreeDCardEffectScreen(),
    },
    {
      'title': 'Smart Home Dashboard',
      'description': 'IoT control with real-time data',
      'icon': Icons.home,
      'color': const Color(0xFF059669),
      'screen': const SmartHomeDashboardScreen(),
    },
    {
      'title': 'Crypto Trading App',
      'description': 'Real-time charts and portfolio tracking',
      'icon': Icons.trending_up,
      'color': const Color(0xFF16A34A),
      'screen': const CryptoTradingScreen(),
    },
    {
      'title': 'Fitness Tracker',
      'description': 'Workout analytics and progress charts',
      'icon': Icons.fitness_center,
      'color': const Color(0xFFDC2626),
      'screen': const FitnessTrackerScreen(),
    },
    {
      'title': 'Food Delivery App',
      'description': 'Restaurant discovery and ordering',
      'icon': Icons.restaurant,
      'color': const Color(0xFFEA580C),
      'screen': const FoodDeliveryScreen(),
    },
    // {
    //   'title': 'Music Streaming',
    //   'description': 'Playlist curation and audio visualization',
    //   'icon': Icons.music_note,
    //   'color': const Color(0xFF7C2D12),
    //   'screen': const MusicStreamingScreen(),
    // },
    {
      'title': 'Travel Booking',
      'description': 'Flight search and hotel reservations',
      'icon': Icons.flight,
      'color': const Color(0xFF0EA5E9),
      'screen': const TravelBookingScreen(),
    },
    {
      'title': 'E-commerce Store',
      'description': 'Product catalog with AR preview',
      'icon': Icons.shopping_bag,
      'color': const Color(0xFF9333EA),
      'screen': const EcommerceStoreScreen(),
    },
    {
      'title': 'Social Media Feed',
      'description': 'Content discovery with stories',
      'icon': Icons.people,
      'color': const Color(0xFFE11D48),
      'screen': const SocialMediaFeedScreen(),
    },
    // {
    //   'title': 'Banking App',
    //   'description': 'Account management and transactions',
    //   'icon': Icons.account_balance,
    //   'color': const Color(0xFF1E40AF),
    //   'screen': const BankingAppScreen(),
    // },
    {
      'title': 'Weather App',
      'description': 'Forecast with animated backgrounds',
      'icon': Icons.wb_sunny,
      'color': const Color(0xFFF59E0B),
      'screen': const WeatherAppScreen(),
    },
    {
      'title': 'Task Manager',
      'description': 'Project collaboration and timelines',
      'icon': Icons.task_alt,
      'color': const Color(0xFF059669),
      'screen': const TaskManagerScreen(),
    },
    {
      'title': 'News Reader',
      'description': 'Personalized content curation',
      'icon': Icons.article,
      'color': const Color(0xFF1F2937),
      'screen': const NewsReaderScreen(),
    },
    {
      'title': 'Photo Editor',
      'description': 'Advanced filters and effects',
      'icon': Icons.photo_camera,
      'color': const Color(0xFF7C3AED),
      'screen': const PhotoEditorScreen(),
    },
    {
      'title': 'Language Learning',
      'description': 'Interactive lessons and progress',
      'icon': Icons.language,
      'color': const Color(0xFFDC2626),
      'screen': const LanguageLearningScreen(),
    },
    {
      'title': 'Meditation App',
      'description': 'Guided sessions and mindfulness',
      'icon': Icons.self_improvement,
      'color': const Color(0xFF8B5CF6),
      'screen': const MeditationAppScreen(),
    },
    {
      'title': 'Car Sharing',
      'description': 'Vehicle booking and navigation',
      'icon': Icons.directions_car,
      'color': const Color(0xFF1E40AF),
      'screen': const CarSharingScreen(),
    },
    {
      'title': 'Event Planner',
      'description': 'Calendar integration and RSVPs',
      'icon': Icons.event,
      'color': const Color(0xFFEA580C),
      'screen': const EventPlannerScreen(),
    },
    {
      'title': 'Recipe Finder',
      'description': 'Ingredient search and cooking guides',
      'icon': Icons.restaurant_menu,
      'color': const Color(0xFF16A34A),
      'screen': const RecipeFinderScreen(),
    },
    {
      'title': 'Pet Care Tracker',
      'description': 'Health monitoring and activities',
      'icon': Icons.pets,
      'color': const Color(0xFF7C2D12),
      'screen': const PetCareTrackerScreen(),
    },
    // {
    //   'title': 'Plant Care App',
    //   'description': 'Watering schedules and growth tracking',
    //   'icon': Icons.local_florist,
    //   'color': const Color(0xFF059669),
    //   'screen': const PlantCareAppScreen(),
    // },
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

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


              // Grid of UI trends
              Expanded(
                child: GridView.builder(
                  scrollDirection: Axis.vertical,
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.85,
                  ),
                  itemCount: uiTrends.length,
                  itemBuilder: (context, index) {
                    final trend = uiTrends[index];
                    return _buildTrendCard(trend, index);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTrendCard(Map<String, dynamic> trend, int index) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, 50 * (1 - _fadeAnimation.value)),
          child: Opacity(
            opacity: _fadeAnimation.value,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        trend['screen'],
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                    transitionDuration: const Duration(milliseconds: 300),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      trend['color'].withOpacity(0.8),
                      trend['color'].withOpacity(0.4),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: trend['color'].withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(trend['icon'], size: 48, color: Colors.white)
                                .animate(delay: (index * 100).ms)
                                .scale(
                                  begin: const Offset(0, 0),
                                  end: const Offset(1, 1),
                                )
                                .then()
                                .shake(hz: 4),
                            const SizedBox(height: 16),
                            Text(
                              trend['title'],
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              trend['description'],
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: Colors.white70,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
