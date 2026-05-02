import 'package:flutter/material.dart';
import '../../../../../core/constants/app_colors.dart';

class HomeHeader extends StatelessWidget {
  final String userName;
  final String profileImageUrl;

  const HomeHeader({
    super.key,
    required this.userName,
    required this.profileImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // User Profile on the Right (RTL means start is right, end is left)
          // Since we are in an LTR/RTL agnostic structure, let's use Row normally.
          // The design has user on the right, bell on the left.
          Expanded(
            child: Row(
              children: [
                _buildProfileImage(),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'صباح الخير 👋',
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'مرحباً، $userName',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Notification Bell
          Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              color: const Color(0xFF1E1E1E),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                const Icon(
                  Icons.notifications_none,
                  color: Colors.white,
                  size: 24,
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    height: 10,
                    width: 10,
                    decoration: BoxDecoration(
                      color: AppColors.neonGreen,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.background, width: 2),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileImage() {
    return Container(
      height: 48,
      width: 48,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.neonGreen.withValues(alpha: 0.5), width: 2),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Image.network(
              profileImageUrl,
              fit: BoxFit.cover,
              width: 48,
              height: 48,
              errorBuilder: (_, __, ___) => const Icon(Icons.person, color: Colors.white),
            ),
          ),
          Positioned(
            bottom: -2,
            left: -2, // In RTL, this positions it on the left bottom edge
            child: Container(
              height: 12,
              width: 12,
              decoration: BoxDecoration(
                color: AppColors.neonGreen,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.background, width: 2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
