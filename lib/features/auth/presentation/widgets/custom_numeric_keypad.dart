import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class CustomNumericKeypad extends StatelessWidget {
  final Function(String) onDigitPressed;
  final VoidCallback onBackspacePressed;

  const CustomNumericKeypad({
    super.key,
    required this.onDigitPressed,
    required this.onBackspacePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 32, top: 8),
      decoration: const BoxDecoration(
        color: Color(0xFF1C1C1E),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
        border: Border(
          top: BorderSide(
            color: Colors.white10,
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          width: 300,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildRow(context, ['1', '2', '3']),
              _buildRow(context, ['4', '5', '6']),
              _buildRow(context, ['7', '8', '9']),
              _buildRow(context, [null, '0', 'backspace']),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRow(BuildContext context, List<String?> keys) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: keys.map((key) {
          if (key == null) {
            return const SizedBox(width: 80, height: 48);
          }
          if (key == 'backspace') {
            return _buildKey(
              context: context,
              child: const Icon(
                Icons.backspace_outlined,
                color: Colors.white,
                size: 28,
              ),
              onTap: onBackspacePressed,
            );
          }
          return _buildKey(
            context: context,
            child: Text(
              key,
              style: const TextStyle(
                fontSize: 28,
                color: Colors.white,
                fontFamily: 'Plus Jakarta Sans', // Use display font
              ),
            ),
            onTap: () => onDigitPressed(key),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildKey({
    required BuildContext context,
    required Widget child,
    required VoidCallback onTap,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          splashColor: AppColors.neonGreen.withValues(alpha: 0.1),
          highlightColor: AppColors.neonGreen.withValues(alpha: 0.05),
          child: Container(
            width: 80,
            height: 54,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white.withValues(alpha: 0.03),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.05),
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
