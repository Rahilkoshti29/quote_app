import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quote_app/quotes_data.dart';
import 'package:quote_app/quote_card.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  String _selected = 'All';

  List<Quote> get _filteredQuotes => _selected == 'All'
      ? allQuotes
      : allQuotes.where((q) => q.category == _selected).toList();

  static const _categoryColors = {
    'Motivation': Color(0xFFFF6B35),
    'Wisdom': Color(0xFF9B59B6),
    'Success': Color(0xFFFFD700),
    'Life': Color(0xFF2ECC71),
    'Courage': Color(0xFF3498DB),
    'Happiness': Color(0xFFF39C12),
    'Mindset': Color(0xFF1ABC9C),
    'Creativity': Color(0xFFE91E63),
    'Perseverance': Color(0xFFE74C3C),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0F),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Text(
                'Categories',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Category grid
            SizedBox(
              height: 110,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 10),
                itemBuilder: (_, i) {
                  final cat = categories[i];
                  final active = _selected == cat;
                  final color = cat == 'All'
                      ? const Color(0xFFFFD700)
                      : _categoryColors[cat] ?? const Color(0xFFFFD700);
                  final count = cat == 'All'
                      ? allQuotes.length
                      : allQuotes.where((q) => q.category == cat).length;
                  return GestureDetector(
                    onTap: () {
                      HapticFeedback.selectionClick();
                      setState(() => _selected = cat);
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      width: 90,
                      decoration: BoxDecoration(
                        gradient: active
                            ? LinearGradient(
                          colors: [color, color.withOpacity(0.6)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                            : null,
                        color: active ? null : const Color(0xFF141420),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: active
                              ? color
                              : Colors.white.withOpacity(0.07),
                          width: active ? 1.5 : 1,
                        ),
                        boxShadow: active
                            ? [BoxShadow(color: color.withOpacity(0.25), blurRadius: 12)]
                            : [],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            categoryEmojis[cat] ?? '✨',
                            style: const TextStyle(fontSize: 28),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            cat,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: active ? Colors.black : Colors.white.withOpacity(0.6),
                            ),
                          ),
                          Text(
                            '$count',
                            style: GoogleFonts.inter(
                              fontSize: 10,
                              color: active
                                  ? Colors.black.withOpacity(0.6)
                                  : Colors.white.withOpacity(0.3),
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

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                '${_filteredQuotes.length} quotes',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: Colors.white.withOpacity(0.35),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Quote list
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
                itemCount: _filteredQuotes.length,
                separatorBuilder: (_, __) => const SizedBox(height: 14),
                itemBuilder: (_, i) {
                  final q = _filteredQuotes[i];
                  return QuoteCard(
                    quote: q,
                    onFavoriteToggle: () => setState(() {
                      if (favoriteIds.contains(q.id)) {
                        favoriteIds.remove(q.id);
                        q.isFavorite = false;
                      } else {
                        favoriteIds.add(q.id);
                        q.isFavorite = true;
                      }
                    }),
                    onShare: () => _copy(q),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _copy(Quote q) {
    Clipboard.setData(ClipboardData(text: '"${q.text}"\n— ${q.author}'));
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
}