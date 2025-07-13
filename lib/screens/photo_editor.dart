import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PhotoEditorScreen extends StatefulWidget {
  const PhotoEditorScreen({super.key});

  @override
  State<PhotoEditorScreen> createState() => _PhotoEditorScreenState();
}

class _PhotoEditorScreenState extends State<PhotoEditorScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  int _selectedTool = 0;
  double _brightness = 0.0;
  double _contrast = 1.0;
  double _saturation = 1.0;
  double _blur = 0.0;
  String _selectedFilter = 'None';

  final List<Map<String, dynamic>> _tools = [
    {'name': 'Filters', 'icon': Icons.filter, 'color': Colors.purple},
    {'name': 'Adjust', 'icon': Icons.tune, 'color': Colors.blue},
    {'name': 'Crop', 'icon': Icons.crop, 'color': Colors.green},
    {'name': 'Text', 'icon': Icons.text_fields, 'color': Colors.orange},
    {'name': 'Stickers', 'icon': Icons.emoji_emotions, 'color': Colors.pink},
  ];

  final List<Map<String, dynamic>> _filters = [
    {'name': 'None', 'icon': Icons.circle_outlined, 'color': Colors.white},
    {'name': 'Vintage', 'icon': Icons.circle, 'color': const Color(0xFF8B4513)},
    {
      'name': 'Dramatic',
      'icon': Icons.circle,
      'color': const Color(0xFF2C1810),
    },
    {'name': 'Warm', 'icon': Icons.circle, 'color': const Color(0xFFFF8C42)},
    {'name': 'Cool', 'icon': Icons.circle, 'color': const Color(0xFF4A90E2)},
    {
      'name': 'Black & White',
      'icon': Icons.circle,
      'color': const Color(0xFF808080),
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
                        child: Text(
                          'Photo Editor',
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          // Save photo
                        },
                        icon: const Icon(Icons.save, color: Colors.white),
                      ),
                      IconButton(
                        onPressed: () {
                          // Share photo
                        },
                        icon: const Icon(Icons.share, color: Colors.white),
                      ),
                    ],
                  ),
                ),

                // Photo Display Area
                Expanded(
                  flex: 3,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 24),
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
                          // Background Image Placeholder
                          Container(
                            width: double.infinity,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Colors.blue.withOpacity(0.8),
                                  Colors.purple.withOpacity(0.8),
                                  Colors.pink.withOpacity(0.8),
                                ],
                              ),
                            ),
                            child: const Icon(
                              Icons.photo_camera,
                              size: 80,
                              color: Colors.white54,
                            ),
                          ),

                          // Filter Overlay
                          if (_selectedFilter != 'None')
                            Container(
                              width: double.infinity,
                              height: double.infinity,
                              color: _getFilterColor(
                                _selectedFilter,
                              ).withOpacity(0.3),
                            ),

                          // Adjustment Overlays
                          Container(
                            width: double.infinity,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(_brightness * 0.1),
                            ),
                          ),

                          // Center Text
                          const Center(
                            child: Text(
                              'Tap to select photo',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Tools Bar
                Container(
                  height: 80,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _tools.length,
                    itemBuilder: (context, index) {
                      final tool = _tools[index];
                      final isSelected = _selectedTool == index;
                      return Container(
                        margin: const EdgeInsets.only(right: 16),
                        child: GestureDetector(
                          onTap: () => setState(() => _selectedTool = index),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? tool['color'].withOpacity(0.3)
                                      : Colors.white.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                    color: isSelected
                                        ? tool['color']
                                        : Colors.white.withOpacity(0.2),
                                    width: isSelected ? 2 : 1,
                                  ),
                                ),
                                child: Icon(
                                  tool['icon'],
                                  color: isSelected
                                      ? tool['color']
                                      : Colors.white,
                                  size: 24,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                tool['name'],
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: isSelected
                                      ? FontWeight.w600
                                      : FontWeight.w400,
                                  color: isSelected
                                      ? tool['color']
                                      : Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 16),

                // Tool Options
                if (_selectedTool == 0) _buildFilterOptions(),
                if (_selectedTool == 1) _buildAdjustmentOptions(),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterOptions() {
    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Filters',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _filters.length,
              itemBuilder: (context, index) {
                final filter = _filters[index];
                final isSelected = _selectedFilter == filter['name'];
                return Container(
                  margin: const EdgeInsets.only(right: 16),
                  child: GestureDetector(
                    onTap: () =>
                        setState(() => _selectedFilter = filter['name']),
                    child: Column(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: filter['color'].withOpacity(0.3),
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: isSelected
                                  ? Colors.white
                                  : Colors.white.withOpacity(0.2),
                              width: isSelected ? 2 : 1,
                            ),
                          ),
                          child: Icon(
                            filter['icon'],
                            color: filter['color'],
                            size: 30,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          filter['name'],
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.w400,
                            color: isSelected ? Colors.white : Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdjustmentOptions() {
    return Container(
      height: 200,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Adjustments',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          _buildSlider(
            'Brightness',
            _brightness,
            -1.0,
            1.0,
            Icons.brightness_6,
            (value) => setState(() => _brightness = value),
          ),
          const SizedBox(height: 16),
          _buildSlider(
            'Contrast',
            _contrast,
            0.0,
            2.0,
            Icons.contrast,
            (value) => setState(() => _contrast = value),
          ),
          const SizedBox(height: 16),
          _buildSlider(
            'Saturation',
            _saturation,
            0.0,
            2.0,
            Icons.palette,
            (value) => setState(() => _saturation = value),
          ),
          const SizedBox(height: 16),
          _buildSlider(
            'Blur',
            _blur,
            0.0,
            10.0,
            Icons.blur_on,
            (value) => setState(() => _blur = value),
          ),
        ],
      ),
    );
  }

  Widget _buildSlider(
    String label,
    double value,
    double min,
    double max,
    IconData icon,
    Function(double) onChanged,
  ) {
    return Row(
      children: [
        Icon(icon, color: Colors.white, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    label,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    value.toStringAsFixed(1),
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: Colors.blue,
                  inactiveTrackColor: Colors.white.withOpacity(0.2),
                  thumbColor: Colors.blue,
                  overlayColor: Colors.blue.withOpacity(0.2),
                  trackHeight: 4,
                ),
                child: Slider(
                  value: value,
                  min: min,
                  max: max,
                  onChanged: onChanged,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Color _getFilterColor(String filterName) {
    switch (filterName) {
      case 'Vintage':
        return const Color(0xFF8B4513);
      case 'Dramatic':
        return const Color(0xFF2C1810);
      case 'Warm':
        return const Color(0xFFFF8C42);
      case 'Cool':
        return const Color(0xFF4A90E2);
      case 'Black & White':
        return const Color(0xFF808080);
      default:
        return Colors.transparent;
    }
  }
}
