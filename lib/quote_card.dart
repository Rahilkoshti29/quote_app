import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quote_app/quotes_data.dart';

// ── Quote Card ─────────────────────────────────────────────────────────────────
class QuoteCard extends StatefulWidget {
  final Quote quote;
  final VoidCallback? onFavoriteToggle;
  final VoidCallback? onShare;
  final bool showActions;

  const QuoteCard({
    super.key,
    required this.quote,
    this.onFavoriteToggle,
    this.onShare,
    this.showActions = true,
  });

  @override
  State<QuoteCard> createState() => _QuoteCardState();
}

class _QuoteCardState extends State<QuoteCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _heartCtrl;
  late Animation<double> _heartAnim;

  @override
  void initState() {
    super.initState();
    _heartCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _heartAnim = Tween<double>(begin: 1.0, end: 1.4).animate(
      CurvedAnimation(parent: _heartCtrl, curve: Curves.elasticOut),
    );
  }

  @override
  void dispose() {
    _heartCtrl.dispose();
    super.dispose();
  }

  void _toggleFav() {
    _heartCtrl.forward().then((_) => _heartCtrl.reverse());
    widget.onFavoriteToggle?.call();
  }

  Color get _categoryColor {
    const colors = {
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
    return colors[widget.quote.category] ?? const Color(0xFFB8860B);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF141420),
            const Color(0xFF1A1A2E),
            _categoryColor.withOpacity(0.08),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: _categoryColor.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: _categoryColor.withOpacity(0.08),
            blurRadius: 30,
            spreadRadius: 5,
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category badge
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  decoration: BoxDecoration(
                    color: _categoryColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: _categoryColor.withOpacity(0.4)),
                  ),
                  child: Text(
                    '${categoryEmojis[widget.quote.category] ?? ''} ${widget.quote.category}',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: _categoryColor,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                if (widget.showActions)
                  ScaleTransition(
                    scale: _heartAnim,
                    child: GestureDetector(
                      onTap: _toggleFav,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          color: widget.quote.isFavorite
                              ? const Color(0xFFE74C3C).withOpacity(0.2)
                              : Colors.white.withOpacity(0.05),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          widget.quote.isFavorite
                              ? Icons.favorite_rounded
                              : Icons.favorite_border_rounded,
                          color: widget.quote.isFavorite
                              ? const Color(0xFFE74C3C)
                              : Colors.white.withOpacity(0.4),
                          size: 18,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 28),

            // Opening quote mark
            Text(
              '\u201C',
              style: GoogleFonts.playfairDisplay(
                fontSize: 72,
                color: _categoryColor.withOpacity(0.3),
                height: 0.5,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),

            // Quote text
            Text(
              widget.quote.text,
              style: GoogleFonts.playfairDisplay(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.white.withOpacity(0.92),
                height: 1.65,
                letterSpacing: 0.2,
              ),
            ),
            const SizedBox(height: 28),

            // Divider
            Row(children: [
              Container(
                width: 36,
                height: 1.5,
                color: _categoryColor.withOpacity(0.5),
              ),
              const SizedBox(width: 10),
              Container(width: 8, height: 8, decoration: BoxDecoration(color: _categoryColor, shape: BoxShape.circle)),
            ]),
            const SizedBox(height: 16),

            // Author
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '— ${widget.quote.author}',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white.withOpacity(0.55),
                    letterSpacing: 0.5,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                if (widget.showActions)
                  GestureDetector(
                    onTap: widget.onShare,
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.06),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.share_rounded,
                          size: 16, color: Colors.white.withOpacity(0.45)),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}