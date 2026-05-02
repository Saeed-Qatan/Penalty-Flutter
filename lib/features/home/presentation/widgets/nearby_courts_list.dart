import 'package:flutter/material.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../domain/entities/court.dart';

class NearbyCourtsList extends StatelessWidget {
  final List<Court> courts;

  const NearbyCourtsList({super.key, required this.courts});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'ملاعب قريبة منك',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  const Text(
                    'عرض الكل',
                    style: TextStyle(
                      color: AppColors.neonGreen,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    Icons.arrow_forward_ios, // Uses LTR direction arrow logic usually, but let's use arrow_back for RTL or arrow_forward depends on flutter auto-direction
                    color: AppColors.neonGreen,
                    size: 14,
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 320,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: courts.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: NearbyCourtCard(court: courts[index]),
              );
            },
          ),
        ),
      ],
    );
  }
}

class NearbyCourtCard extends StatelessWidget {
  final Court court;

  const NearbyCourtCard({super.key, required this.court});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image and badges
          Container(
            height: 180,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              image: DecorationImage(
                image: NetworkImage(court.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.star, color: Colors.yellow, size: 14),
                        const SizedBox(width: 4),
                        Text(
                          court.rating.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    height: 32,
                    width: 32,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                    ),
                    child: const Icon(Icons.favorite_border, color: Colors.white, size: 18),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // Details
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      court.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${court.price.toInt()} ر.س',
                      style: const TextStyle(
                        color: AppColors.neonGreen,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined, color: Colors.white54, size: 14),
                    const SizedBox(width: 4),
                    Text(
                      '${court.distance} كم',
                      style: const TextStyle(color: Colors.white54, fontSize: 12),
                    ),
                    const SizedBox(width: 16),
                    const Icon(Icons.sports_soccer, color: Colors.white54, size: 14),
                    const SizedBox(width: 4),
                    Text(
                      court.type,
                      style: const TextStyle(color: Colors.white54, fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1E1E1E),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      side: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
                    ),
                    child: const Text('حجز سريع', style: TextStyle(fontWeight: FontWeight.bold)),
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
