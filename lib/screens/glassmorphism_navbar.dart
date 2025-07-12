import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';

class GlassmorphismNavbarScreen extends StatefulWidget {
  const GlassmorphismNavbarScreen({super.key});

  @override
  State<GlassmorphismNavbarScreen> createState() =>
      _GlassmorphismNavbarScreenState();
}

class _GlassmorphismNavbarScreenState extends State<GlassmorphismNavbarScreen> {
  int _selectedIndex = 0;

  final List<IconData> _icons = [
    Icons.home,
    Icons.search,
    Icons.favorite,
    Icons.person,
  ];

  final List<String> _labels = ['Home', 'Search', 'Likes', 'Profile'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: const Color(0xFF1E293B),
      body: Center(
        child: Text(
          _labels[_selectedIndex],
          style: GoogleFonts.poppins(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              height: 70,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(30),
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
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(_icons.length, (index) {
                  final isSelected = _selectedIndex == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.white.withOpacity(0.2)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            _icons[index],
                            color: isSelected ? Colors.white : Colors.white70,
                            size: isSelected ? 32 : 28,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _labels[index],
                            style: GoogleFonts.poppins(
                              fontSize: isSelected ? 14 : 12,
                              color: isSelected ? Colors.white : Colors.white70,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
