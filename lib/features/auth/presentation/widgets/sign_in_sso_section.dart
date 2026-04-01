import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/localization/locale_keys.dart';
import '../../../../core/widgets/sso_button.dart';
import 'google_logo_painter.dart';

class SignInSsoSection extends StatelessWidget {
  const SignInSsoSection({
    super.key,
    this.onGoogleTap,
    this.onAppleTap,
  });

  final VoidCallback? onGoogleTap;
  final VoidCallback? onAppleTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SsoButton(
          icon: SizedBox(
            width: 20,
            height: 20,
            child: CustomPaint(painter: GoogleLogoPainter()),
          ),
          label: LocaleKeys.continueWithGoogle.tr(),
          onPressed: onGoogleTap,
        ),
        const SizedBox(height: 12),
        SsoButton(
          icon: const Icon(Icons.apple, color: AppColors.white, size: 24),
          label: LocaleKeys.continueWithApple.tr(),
          onPressed: onAppleTap,
        ),
      ],
    );
  }
}
