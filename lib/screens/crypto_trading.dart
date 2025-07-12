import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';

class CryptoTradingScreen extends StatefulWidget {
  const CryptoTradingScreen({super.key});

  @override
  State<CryptoTradingScreen> createState() => _CryptoTradingScreenState();
}

class _CryptoTradingScreenState extends State<CryptoTradingScreen>
    with TickerProviderStateMixin {
  late AnimationController _chartController;
  final double _btcPrice = 43250.75;
  final double _ethPrice = 2650.30;
  final double _portfolioValue = 125430.50;
  final double _profitLoss = 2340.25;

  @override
  void initState() {
    super.initState();
    _chartController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _chartController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: SafeArea(
        child: Column(
          children: [
            // App bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white.withOpacity(0.1),
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    'Crypto Trading',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _buildPortfolioCard(),
                  _buildPriceChart(),
                  _buildCryptoList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPortfolioCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [const Color(0xFF16A34A), const Color(0xFF22C55E)],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.account_balance_wallet, size: 32, color: Colors.white),
              const SizedBox(width: 12),
              Text(
                'Portfolio Value',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            '\$${_portfolioValue.toStringAsFixed(2)}',
            style: GoogleFonts.poppins(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(
                _profitLoss >= 0 ? Icons.trending_up : Icons.trending_down,
                color: Colors.white,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                '${_profitLoss >= 0 ? '+' : ''}\$${_profitLoss.toStringAsFixed(2)}',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.3);
  }

  Widget _buildPriceChart() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white.withOpacity(0.1),
        border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'BTC/USD Chart',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: CustomPaint(
                painter: ChartPainter(_chartController),
                size: const Size(double.infinity, 100),
              ),
            ),
          ],
        ),
      ),
    ).animate(delay: 200.ms).fadeIn(duration: 600.ms).slideY(begin: 0.3);
  }

  Widget _buildCryptoList() {
    final cryptos = [
      {
        'name': 'Bitcoin',
        'symbol': 'BTC',
        'price': _btcPrice,
        'change': 2.45,
        'icon': Icons.currency_bitcoin,
      },
      {
        'name': 'Ethereum',
        'symbol': 'ETH',
        'price': _ethPrice,
        'change': -1.23,
        'icon': Icons.currency_exchange,
      },
      {
        'name': 'Cardano',
        'symbol': 'ADA',
        'price': 0.485,
        'change': 5.67,
        'icon': Icons.currency_bitcoin,
      },
    ];

    return Column(
      children: cryptos.asMap().entries.map((entry) {
        final index = entry.key;
        final crypto = entry.value;
        return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white.withOpacity(0.1),
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF16A34A).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      crypto['icon'] as IconData,
                      color: const Color(0xFF16A34A),
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          crypto['name'] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          crypto['symbol'] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '\$${(crypto['price'] as double).toStringAsFixed(2)}',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '${(crypto['change'] as double) >= 0 ? '+' : ''}${(crypto['change'] as double).toStringAsFixed(2)}%',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: (crypto['change'] as double) >= 0
                              ? const Color(0xFF16A34A)
                              : const Color(0xFFDC2626),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
            .animate(delay: Duration(milliseconds: 400 + (index * 100)))
            .fadeIn(duration: 600.ms)
            .slideX(begin: 0.3);
      }).toList(),
    );
  }
}

class ChartPainter extends CustomPainter {
  final AnimationController animation;

  ChartPainter(this.animation) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF16A34A)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path();
    final points = <Offset>[];

    for (int i = 0; i < 50; i++) {
      final x = (i / 49) * size.width;
      final y =
          size.height * 0.5 + 30 * sin(animation.value * 2 * pi + i * 0.2);
      points.add(Offset(x, y));
    }

    if (points.isNotEmpty) {
      path.moveTo(points.first.dx, points.first.dy);
      for (int i = 1; i < points.length; i++) {
        path.lineTo(points[i].dx, points[i].dy);
      }
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(ChartPainter oldDelegate) => true;
}
