import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/localization/locale_keys.dart';
import '../bloc/sign_up_state.dart';

class PasswordStrengthIndicator extends StatelessWidget {
  final PasswordStrength strength;

  const PasswordStrengthIndicator({super.key, required this.strength});

  @override
  Widget build(BuildContext context) {
    if (strength == PasswordStrength.none) return const SizedBox.shrink();

    String text;
    Color color;
    double widthFactor;

    switch (strength) {
      case PasswordStrength.weak:
        text = LocaleKeys.weak.tr();
        color = Colors.red;
        widthFactor = 0.3;
        break;
      case PasswordStrength.medium:
        text = LocaleKeys.medium.tr();
        color = Colors.orange;
        widthFactor = 0.6;
        break;
      case PasswordStrength.strong:
        text = LocaleKeys.strong.tr();
        color = AppColors.neonGreen;
        widthFactor = 1.0;
        break;
      case PasswordStrength.none:
        return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 6,
              decoration: BoxDecoration(
                color: AppColors.divider,
                borderRadius: BorderRadius.circular(4),
              ),
              alignment: AlignmentDirectional.centerStart,
              child: FractionallySizedBox(
                widthFactor: widthFactor,
                child: Container(
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: [
                      BoxShadow(color: color.withOpacity(0.6), blurRadius: 8),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
