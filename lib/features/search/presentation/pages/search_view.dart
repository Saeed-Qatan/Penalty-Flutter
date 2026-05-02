import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Text(
          'Search Content',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    );
  }
}
