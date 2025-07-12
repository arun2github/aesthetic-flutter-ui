import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';

class RecipeFinderScreen extends StatefulWidget {
  const RecipeFinderScreen({super.key});

  @override
  State<RecipeFinderScreen> createState() => _RecipeFinderScreenState();
}

class _RecipeFinderScreenState extends State<RecipeFinderScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  String _searchQuery = '';
  int _selectedCategory = 0;
  final List<String> _selectedDietary = [];

  final List<String> _categories = [
    'All',
    'Breakfast',
    'Lunch',
    'Dinner',
    'Dessert',
    'Snacks',
    'Drinks',
  ];

  final List<String> _dietaryOptions = [
    'Vegetarian',
    'Vegan',
    'Gluten-Free',
    'Dairy-Free',
    'Low-Carb',
    'Keto',
  ];

  final List<Map<String, dynamic>> _recipes = [
    {
      'id': '1',
      'title': 'Avocado Toast with Poached Eggs',
      'description': 'A healthy and delicious breakfast option',
      'category': 'Breakfast',
      'cookTime': '15 min',
      'servings': 2,
      'difficulty': 'Easy',
      'rating': 4.8,
      'image': 'https://images.unsplash.com/photo-1541519227354-08fa5d50c44d',
      'ingredients': [
        '2 slices whole grain bread',
        '1 ripe avocado',
        '2 eggs',
        'Salt and pepper',
        'Red pepper flakes',
        'Fresh herbs',
      ],
      'instructions': [
        'Toast the bread until golden brown',
        'Mash the avocado and spread on toast',
        'Poach the eggs in simmering water',
        'Place eggs on top and season',
      ],
      'dietary': ['Vegetarian', 'Gluten-Free'],
      'calories': 320,
      'isFavorite': true,
    },
    {
      'id': '2',
      'title': 'Grilled Salmon with Vegetables',
      'description': 'Fresh salmon with seasonal vegetables',
      'category': 'Dinner',
      'cookTime': '25 min',
      'servings': 4,
      'difficulty': 'Medium',
      'rating': 4.6,
      'image': 'https://images.unsplash.com/photo-1467003909585-2f8a72700288',
      'ingredients': [
        '4 salmon fillets',
        '2 cups mixed vegetables',
        'Olive oil',
        'Lemon juice',
        'Garlic',
        'Herbs and spices',
      ],
      'instructions': [
        'Season salmon with herbs and spices',
        'Grill salmon for 6-8 minutes per side',
        'Sauté vegetables until tender',
        'Serve with lemon wedges',
      ],
      'dietary': ['Gluten-Free', 'Dairy-Free'],
      'calories': 450,
      'isFavorite': false,
    },
    {
      'id': '3',
      'title': 'Chocolate Chip Cookies',
      'description': 'Classic homemade chocolate chip cookies',
      'category': 'Dessert',
      'cookTime': '30 min',
      'servings': 12,
      'difficulty': 'Easy',
      'rating': 4.9,
      'image': 'https://images.unsplash.com/photo-1499636136210-6f4ee915583e',
      'ingredients': [
        '2 cups all-purpose flour',
        '1 cup butter',
        '1 cup chocolate chips',
        '3/4 cup sugar',
        '2 eggs',
        'Vanilla extract',
      ],
      'instructions': [
        'Cream butter and sugar together',
        'Add eggs and vanilla, mix well',
        'Stir in flour and chocolate chips',
        'Bake at 350°F for 10-12 minutes',
      ],
      'dietary': ['Vegetarian'],
      'calories': 180,
      'isFavorite': true,
    },
    {
      'id': '4',
      'title': 'Quinoa Buddha Bowl',
      'description': 'Nutritious and colorful vegetarian bowl',
      'category': 'Lunch',
      'cookTime': '20 min',
      'servings': 2,
      'difficulty': 'Easy',
      'rating': 4.7,
      'image': 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd',
      'ingredients': [
        '1 cup quinoa',
        '1 cup chickpeas',
        'Mixed vegetables',
        'Tahini dressing',
        'Nuts and seeds',
        'Fresh herbs',
      ],
      'instructions': [
        'Cook quinoa according to package',
        'Roast chickpeas and vegetables',
        'Prepare tahini dressing',
        'Assemble bowl with toppings',
      ],
      'dietary': ['Vegetarian', 'Vegan', 'Gluten-Free'],
      'calories': 380,
      'isFavorite': false,
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

  List<Map<String, dynamic>> get _filteredRecipes {
    return _recipes.where((recipe) {
      final matchesCategory =
          _selectedCategory == 0 ||
          recipe['category'] == _categories[_selectedCategory];
      final matchesSearch =
          _searchQuery.isEmpty ||
          recipe['title'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
          recipe['description'].toLowerCase().contains(
            _searchQuery.toLowerCase(),
          );
      final matchesDietary =
          _selectedDietary.isEmpty ||
          _selectedDietary.any((diet) => recipe['dietary'].contains(diet));
      return matchesCategory && matchesSearch && matchesDietary;
    }).toList();
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
                            'Recipe Finder',
                            style: GoogleFonts.poppins(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Discover delicious recipes',
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
                        // Open favorites
                      },
                      icon: const Icon(Icons.favorite, color: Colors.white),
                    ),
                  ],
                ),
              ),

              // Search Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white.withOpacity(0.2)),
                  ),
                  child: TextField(
                    onChanged: (value) => setState(() => _searchQuery = value),
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: 'Search recipes...',
                      hintStyle: TextStyle(color: Colors.white54),
                      border: InputBorder.none,
                      icon: Icon(Icons.search, color: Colors.white54),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Categories
              SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  itemCount: _categories.length,
                  itemBuilder: (context, index) {
                    final isSelected = _selectedCategory == index;
                    return Container(
                      margin: const EdgeInsets.only(right: 12),
                      child: GestureDetector(
                        onTap: () => setState(() => _selectedCategory = index),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Colors.orange.withOpacity(0.3)
                                : Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(
                              color: isSelected
                                  ? Colors.orange.withOpacity(0.5)
                                  : Colors.white.withOpacity(0.2),
                            ),
                          ),
                          child: Text(
                            _categories[index],
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                              color: isSelected ? Colors.white : Colors.white70,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 16),

              // Dietary Filters
              SizedBox(
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  itemCount: _dietaryOptions.length,
                  itemBuilder: (context, index) {
                    final dietary = _dietaryOptions[index];
                    final isSelected = _selectedDietary.contains(dietary);
                    return Container(
                      margin: const EdgeInsets.only(right: 8),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            if (isSelected) {
                              _selectedDietary.remove(dietary);
                            } else {
                              _selectedDietary.add(dietary);
                            }
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Colors.green.withOpacity(0.3)
                                : Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isSelected
                                  ? Colors.green.withOpacity(0.5)
                                  : Colors.white.withOpacity(0.2),
                            ),
                          ),
                          child: Text(
                            dietary,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                              color: isSelected ? Colors.white : Colors.white70,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 24),

              // Recipes List
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  itemCount: _filteredRecipes.length,
                  itemBuilder: (context, index) {
                    return _buildRecipeCard(_filteredRecipes[index], index);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecipeCard(Map<String, dynamic> recipe, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Recipe Image
          Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              gradient: LinearGradient(
                colors: [
                  Colors.orange.withOpacity(0.8),
                  Colors.red.withOpacity(0.8),
                ],
              ),
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.orange.withOpacity(0.6),
                            Colors.red.withOpacity(0.6),
                          ],
                        ),
                      ),
                      child: const Icon(
                        Icons.restaurant,
                        size: 60,
                        color: Colors.white54,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 16,
                  right: 16,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            recipe['isFavorite'] = !recipe['isFavorite'];
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Icon(
                            recipe['isFavorite']
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: recipe['isFavorite']
                                ? Colors.red
                                : Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 14,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              recipe['rating'].toString(),
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
                Positioned(
                  bottom: 16,
                  left: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      recipe['category'],
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Recipe Details
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  recipe['title'],
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  recipe['description'],
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    _buildInfoItem(Icons.access_time, recipe['cookTime']),
                    const SizedBox(width: 16),
                    _buildInfoItem(
                      Icons.people,
                      '${recipe['servings']} servings',
                    ),
                    const SizedBox(width: 16),
                    _buildInfoItem(Icons.trending_up, recipe['difficulty']),
                    const SizedBox(width: 16),
                    _buildInfoItem(
                      Icons.local_fire_department,
                      '${recipe['calories']} cal',
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: recipe['dietary']
                      .map(
                        (diet) => Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            diet,
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: Colors.green,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                          color: Colors.orange.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.orange),
                        ),
                        child: Center(
                          child: Text(
                            'View Recipe',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.orange,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.blue),
                      ),
                      child: const Icon(
                        Icons.share,
                        color: Colors.blue,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate(delay: (index * 100).ms).fadeIn().slideY(begin: 0.3);
  }

  Widget _buildInfoItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.white54, size: 16),
        const SizedBox(width: 4),
        Text(
          text,
          style: GoogleFonts.poppins(fontSize: 12, color: Colors.white54),
        ),
      ],
    );
  }
}
