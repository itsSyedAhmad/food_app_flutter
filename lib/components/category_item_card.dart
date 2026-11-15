import 'package:flutter/material.dart';
import 'package:food_app/theme/app_colors.dart';

class CategoryItemCard extends StatelessWidget {
  final String label;

  final Function() onTap;

  const CategoryItemCard({super.key, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Column(
        children: [
          Container(
            height: 62,
            width: 49,

            decoration: BoxDecoration(
              color: Color(0XFFF3E9B5),
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
          ),
          Container(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.font,
            ),
          ),
        ],
      ),
    );
  }
}
