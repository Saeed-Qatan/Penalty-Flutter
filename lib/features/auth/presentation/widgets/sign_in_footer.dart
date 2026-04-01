import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/localization/locale_keys.dart';

class SignInFooter extends StatelessWidget {
  const SignInFooter({
    super.key,
    this.onSignUpTap,
  });

  final VoidCallback? onSignUpTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          LocaleKeys.dontHaveAccount.tr(),
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.textTertiary,
          ),
        ),
        const SizedBox(width: 4),
        GestureDetector(
          onTap: onSignUpTap,
          child: Text(
            LocaleKeys.signUpNow.tr(),
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.electricBlue,
            ),
          ),
        ),
      ],
    );
  }
}
