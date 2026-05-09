import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quote_app/quotes_data.dart';
import 'package:quote_app/quote_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late Quote _currentQuote;
  final _random = Random();
  late AnimationController _animCtrl;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;
  bool _animating = false;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _currentQuote = _randomQuote();
    _animCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeAnim = CurvedAnimation(parent: _animCtrl, curve: Curves.easeOut);
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.06),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animCtrl, curve: Curves.easeOut));
    _animCtrl.forward();
  }

  @override
  void dispose() {
    _animCtrl.dispose();
    super.dispose();
  }

  Quote _randomQuote() {
    return allQuotes[_random.nextInt(allQuotes.length)];
  }

  Future<void> _nextQuote() async {
    if (_animating) return;

    setState(() {
      _animating = true;
      _loading = true;
    });

    HapticFeedback.lightImpact();

    await Future.delayed(const Duration(milliseconds: 700));

    await _animCtrl.reverse();

    setState(() {
      _currentQuote = _randomQuote();
    });

    await _animCtrl.forward();

    setState(() {
      _animating = false;
      _loading = false;
    });
  }

  void _toggleFavorite() {
    setState(() {
      if (favoriteIds.contains(_currentQuote.id)) {
        favoriteIds.remove(_currentQuote.id);
        _currentQuote.isFavorite = false;
      } else {
        favoriteIds.add(_currentQuote.id);
        _currentQuote.isFavorite = true;
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _currentQuote.isFavorite ? 'Added to favorites ❤️' : 'Removed from favorites',
          style: GoogleFonts.inter(fontSize: 13),
        ),
        backgroundColor: const Color(0xFF1E1E30),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  void _copyQuote() {
    Clipboard.setData(
      ClipboardData(text: '"${_currentQuote.text}"\n— ${_currentQuote.author}'),
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Quote copied! 📋', style: GoogleFonts.inter(fontSize: 13)),
        backgroundColor: const Color(0xFF1E1E30),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0F),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: const Color(0xFF0A0A0F),
            floating: true,
            title: Row(children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFB8860B), Color(0xFFFFD700)],
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.format_quote_rounded,
                    size: 18, color: Colors.black),
              ),
              const SizedBox(width: 10),
              Text(
                'Quotify',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
              ),
            ]),
            actions: [
              IconButton(
                onPressed: _copyQuote,
                icon: Icon(Icons.copy_rounded,
                    color: Colors.white.withOpacity(0.5), size: 20),
                tooltip: 'Copy quote',
              ),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Quote count banner
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFD700).withOpacity(0.07),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: const Color(0xFFFFD700).withOpacity(0.12)),
                  ),
                  child: Row(children: [
                    const Icon(Icons.auto_awesome_rounded,
                        size: 14, color: Color(0xFFFFD700)),
                    const SizedBox(width: 8),
                    Text(
                      '${allQuotes.length} curated quotes across ${categories.length - 1} categories',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: const Color(0xFFFFD700).withOpacity(0.8),
                      ),
                    ),
                  ]),
                ),
                const SizedBox(height: 24),

                // Animated Quote Card
                _loading
                    ? const Center(
                  child: Padding(
                    padding: EdgeInsets.all(40),
                    child: CircularProgressIndicator(
                      color: Color(0xFFFFD700),
                    ),
                  ),
                )
                    : FadeTransition(
                  opacity: _fadeAnim,
                  child: SlideTransition(
                    position: _slideAnim,
                    child: QuoteCard(
                      quote: _currentQuote,
                      onFavoriteToggle: _toggleFavorite,
                      onShare: _copyQuote,
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                // Action buttons row
                Row(children: [
                  // New Quote button (main CTA)
                  Expanded(
                    child: GestureDetector(
                      onTap: _nextQuote,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 150),
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFFB8860B), Color(0xFFFFD700)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFFFD700).withOpacity(0.25),
                              blurRadius: 20,
                              offset: const Offset(0, 6),
                            )
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.refresh_rounded,
                                color: Colors.black, size: 20),
                            const SizedBox(width: 8),
                            Text(
                              'NEW QUOTE',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                                color: Colors.black,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Favorite button
                  GestureDetector(
                    onTap: _toggleFavorite,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 58,
                      height: 58,
                      decoration: BoxDecoration(
                        color: _currentQuote.isFavorite
                            ? const Color(0xFFE74C3C).withOpacity(0.2)
                            : const Color(0xFF1A1A2E),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: _currentQuote.isFavorite
                              ? const Color(0xFFE74C3C).withOpacity(0.5)
                              : Colors.white.withOpacity(0.08),
                        ),
                      ),
                      child: Icon(
                        _currentQuote.isFavorite
                            ? Icons.favorite_rounded
                            : Icons.favorite_border_rounded,
                        color: _currentQuote.isFavorite
                            ? const Color(0xFFE74C3C)
                            : Colors.white.withOpacity(0.4),
                        size: 22,
                      ),
                    ),
                  ),
                ]),
                const SizedBox(height: 28),

                // Quote of the day section
                _buildQOTD(),
                const SizedBox(height: 100),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQOTD() {
    // Deterministic "quote of the day" based on day of year
    final dayOfYear = DateTime.now().difference(DateTime(DateTime.now().year)).inDays;
    final qotd = allQuotes[dayOfYear % allQuotes.length];

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        const Icon(Icons.wb_sunny_rounded, size: 14, color: Color(0xFFFFD700)),
        const SizedBox(width: 6),
        Text(
          'QUOTE OF THE DAY',
          style: GoogleFonts.inter(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: const Color(0xFFFFD700).withOpacity(0.7),
            letterSpacing: 1.5,
          ),
        ),
      ]),
      const SizedBox(height: 12),
      Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF141420),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withOpacity(0.06)),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            '"${qotd.text}"',
            style: GoogleFonts.playfairDisplay(
              fontSize: 15,
              color: Colors.white.withOpacity(0.8),
              height: 1.6,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '— ${qotd.author}',
            style: GoogleFonts.inter(
              fontSize: 12,
              color: Colors.white.withOpacity(0.4),
              fontWeight: FontWeight.w500,
            ),
          ),
        ]),
      ),
    ]);
  }
}