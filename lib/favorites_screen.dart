import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quote_app/quotes_data.dart';
import 'package:quote_app/quote_card.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<Quote> get _favorites =>
      allQuotes.where((q) => favoriteIds.contains(q.id)).toList();

  @override
  Widget build(BuildContext context) {
    final favs = _favorites;

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0F),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Favorites',
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  if (favs.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE74C3C).withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            color: const Color(0xFFE74C3C).withOpacity(0.3)),
                      ),
                      child: Row(children: [
                        const Icon(Icons.favorite_rounded,
                            size: 12, color: Color(0xFFE74C3C)),
                        const SizedBox(width: 4),
                        Text(
                          '${favs.length}',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFFE74C3C),
                          ),
                        ),
                      ]),
                    ),
                ],
              ),
              const SizedBox(height: 20),

              if (favs.isEmpty) ...[
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE74C3C).withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.favorite_border_rounded,
                              size: 36, color: Color(0xFFE74C3C)),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'No favorites yet',
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 20,
                            color: Colors.white.withOpacity(0.7),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Tap the ♥ on any quote to save it here.',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: Colors.white.withOpacity(0.35),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ] else ...[
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.only(bottom: 100),
                    itemCount: favs.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 14),
                    itemBuilder: (_, i) {
                      final q = favs[i];
                      return QuoteCard(
                        quote: q,
                        onFavoriteToggle: () {
                          setState(() {
                            favoriteIds.remove(q.id);
                            q.isFavorite = false;
                          });
                        },
                        onShare: () {
                          Clipboard.setData(ClipboardData(
                              text: '"${q.text}"\n— ${q.author}'));
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Copied! 📋',
                                  style: GoogleFonts.inter(fontSize: 13)),
                              backgroundColor: const Color(0xFF1E1E30),
                              behavior: SnackBarBehavior.floating,
                              duration: const Duration(seconds: 1),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}