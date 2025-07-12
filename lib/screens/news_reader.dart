import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

class NewsReaderScreen extends StatefulWidget {
  const NewsReaderScreen({super.key});

  @override
  State<NewsReaderScreen> createState() => _NewsReaderScreenState();
}

class _NewsReaderScreenState extends State<NewsReaderScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  int _selectedCategory = 0;
  String _searchQuery = '';

  final List<String> _categories = [
    'All',
    'Technology',
    'Business',
    'Science',
    'Health',
    'Entertainment',
    'Sports',
    'Politics',
  ];

  final List<Map<String, dynamic>> _articles = [
    {
      'id': '1',
      'title': 'AI Breakthrough: New Model Achieves Human-Level Reasoning',
      'summary':
          'Researchers at OpenAI have developed a new artificial intelligence model that demonstrates unprecedented reasoning capabilities...',
      'category': 'Technology',
      'author': 'Dr. Sarah Chen',
      'publishedAt': '2 hours ago',
      'readTime': '5 min read',
      'imageUrl':
          'https://images.unsplash.com/photo-1677442136019-21780ecad995',
      'isBookmarked': false,
      'isLiked': false,
    },
    {
      'id': '2',
      'title': 'Global Markets React to Central Bank Policy Changes',
      'summary':
          'Financial markets worldwide experienced significant volatility following coordinated policy announcements from major central banks...',
      'category': 'Business',
      'author': 'Michael Rodriguez',
      'publishedAt': '4 hours ago',
      'readTime': '7 min read',
      'imageUrl':
          'https://images.unsplash.com/photo-1611974789855-9c2a0a7236a3',
      'isBookmarked': true,
      'isLiked': true,
    },
    {
      'id': '3',
      'title': 'Revolutionary Quantum Computing Milestone Achieved',
      'summary':
          'Scientists have successfully demonstrated quantum supremacy in a practical application, marking a historic moment in computing...',
      'category': 'Science',
      'author': 'Prof. James Wilson',
      'publishedAt': '6 hours ago',
      'readTime': '8 min read',
      'imageUrl':
          'https://images.unsplash.com/photo-1635070041078-e363dbe005cb',
      'isBookmarked': false,
      'isLiked': false,
    },
    {
      'id': '4',
      'title': 'New Study Reveals Benefits of Mediterranean Diet',
      'summary':
          'A comprehensive study involving over 10,000 participants shows significant health improvements from Mediterranean diet adoption...',
      'category': 'Health',
      'author': 'Dr. Emily Thompson',
      'publishedAt': '8 hours ago',
      'readTime': '4 min read',
      'imageUrl':
          'https://images.unsplash.com/photo-1490645935967-10de6ba17061',
      'isBookmarked': false,
      'isLiked': true,
    },
    {
      'id': '5',
      'title': 'Blockbuster Movie Breaks Box Office Records',
      'summary':
          'The highly anticipated sci-fi epic has shattered previous opening weekend records, becoming the highest-grossing film of the year...',
      'category': 'Entertainment',
      'author': 'Lisa Park',
      'publishedAt': '10 hours ago',
      'readTime': '3 min read',
      'imageUrl':
          'https://images.unsplash.com/photo-1489599849927-2ee91cede3ba',
      'isBookmarked': true,
      'isLiked': false,
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

  List<Map<String, dynamic>> get _filteredArticles {
    return _articles.where((article) {
      final matchesCategory =
          _selectedCategory == 0 ||
          article['category'] == _categories[_selectedCategory];
      final matchesSearch =
          _searchQuery.isEmpty ||
          article['title'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
          article['summary'].toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
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
                            'News Reader',
                            style: GoogleFonts.poppins(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Stay informed with the latest',
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
                        // Open bookmarks
                      },
                      icon: const Icon(
                        Icons.bookmark_border,
                        color: Colors.white,
                      ),
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
                      hintText: 'Search articles...',
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
                                ? Colors.blue.withOpacity(0.3)
                                : Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(
                              color: isSelected
                                  ? Colors.blue.withOpacity(0.5)
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

              const SizedBox(height: 24),

              // Articles List
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  itemCount: _filteredArticles.length,
                  itemBuilder: (context, index) {
                    return _buildArticleCard(_filteredArticles[index], index);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildArticleCard(Map<String, dynamic> article, int index) {
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
          // Article Image
          Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.blue.withOpacity(0.8),
                  Colors.purple.withOpacity(0.8),
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
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.blue.withOpacity(0.6),
                            Colors.purple.withOpacity(0.6),
                          ],
                        ),
                      ),
                      child: const Icon(
                        Icons.article,
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
                            article['isLiked'] = !article['isLiked'];
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Icon(
                            article['isLiked']
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: article['isLiked']
                                ? Colors.red
                                : Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            article['isBookmarked'] = !article['isBookmarked'];
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Icon(
                            article['isBookmarked']
                                ? Icons.bookmark
                                : Icons.bookmark_border,
                            color: article['isBookmarked']
                                ? Colors.blue
                                : Colors.white,
                            size: 20,
                          ),
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
                      article['category'],
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

          // Article Content
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  article['title'],
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.3,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                Text(
                  article['summary'],
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.white70,
                    height: 1.4,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.blue.withOpacity(0.3),
                      child: Text(
                        article['author'].split(' ').map((e) => e[0]).join(''),
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            article['author'],
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            '${article['publishedAt']} • ${article['readTime']}',
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              color: Colors.white54,
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
                      child: Text(
                        'Read',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.blue,
                        ),
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
}
