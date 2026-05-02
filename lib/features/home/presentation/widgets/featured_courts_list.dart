import 'package:flutter/material.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../domain/entities/court.dart';

class FeaturedCourtsList extends StatelessWidget {
  final List<Court> courts;

  const FeaturedCourtsList({super.key, required this.courts});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            'ملاعب مميزة',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 16),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 24),
          itemCount: courts.length,
          separatorBuilder: (context, index) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            return FeaturedCourtCard(court: courts[index]);
          },
        ),
      ],
    );
  }
}

class FeaturedCourtCard extends StatelessWidget {
  final Court court;

  const FeaturedCourtCard({super.key, required this.court});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Row(
        children: [
          // Image
          SizedBox(
            width: 100,
            height: 96,
            child: ClipRRect(
              borderRadius: const BorderRadius.horizontal(right: Radius.circular(16)), // right because RTL starts right
              child: Image.network(
                court.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Details
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        court.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${court.price.toInt()} ر.س',
                        style: const TextStyle(
                          color: AppColors.neonGreen,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.yellow, size: 12),
                      const SizedBox(width: 4),
                      Text(
                        court.rating.toString(),
                        style: const TextStyle(color: Colors.white54, fontSize: 10),
                      ),
                      const SizedBox(width: 16),
                      const Icon(Icons.location_on_outlined, color: Colors.white54, size: 12),
                      const SizedBox(width: 4),
                      Text(
                        '${court.distance} كم',
                        style: const TextStyle(color: Colors.white54, fontSize: 10),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
