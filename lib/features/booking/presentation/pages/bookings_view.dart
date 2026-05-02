import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class BookingsView extends StatelessWidget {
  const BookingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Text(
          'Bookings Content',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    );
  }
}
