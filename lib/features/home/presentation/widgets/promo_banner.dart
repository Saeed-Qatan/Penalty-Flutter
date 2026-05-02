import 'package:flutter/material.dart';
import '../../domain/entities/promotion.dart';

class PromoBanner extends StatelessWidget {
  final Promotion promotion;

  const PromoBanner({super.key, required this.promotion});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      height: 220,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        image: DecorationImage(
          image: NetworkImage(promotion.imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          // Gradient overlays
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              gradient: const LinearGradient(
                colors: [Color(0xFF2979FF), Colors.transparent],
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              gradient: const LinearGradient(
                colors: [Colors.black54, Colors.transparent],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                  ),
                  child: Text(
                    promotion.discountText,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  promotion.title, // "خصم ٥٠٪\nعلى ملاعب كرة القدم"
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF2979FF),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    elevation: 8,
                  ),
                  child: const Text(
                    'احجز الآن',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
