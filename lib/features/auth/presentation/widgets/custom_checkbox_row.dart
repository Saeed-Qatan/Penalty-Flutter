import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class CustomCheckboxRow extends StatelessWidget {
  final String label;
  final bool value;
  final VoidCallback onTap;

  const CustomCheckboxRow({
    super.key,
    required this.label,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: value ? AppColors.neonGreen : AppColors.surface,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: value ? AppColors.neonGreen : AppColors.divider,
                width: 2,
              ),
            ),
            alignment: Alignment.center,
            child: value
                ? const Icon(Icons.check, size: 18, color: Colors.black)
                : null,
          ),
          const SizedBox(width: 12),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
