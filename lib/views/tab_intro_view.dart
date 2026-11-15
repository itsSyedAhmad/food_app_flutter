import 'package:flutter/material.dart';
import 'package:food_app/theme/app_colors.dart';

class TabIntroView extends StatelessWidget {
  const TabIntroView({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
  });

  final String title;
  final String description;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 56, color: AppColors.orangeBase),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(
                color: AppColors.font,
                fontSize: 26,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.black2, fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
