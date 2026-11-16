import 'package:flutter/material.dart';
import 'package:food_app/enums/food_category.dart';
import 'package:food_app/components/app_layout.dart';

import 'package:food_app/theme/app_colors.dart';

import '../components/category_item_card.dart';

class HomeTabScreen extends StatefulWidget {
  final ValueChanged<FoodCategory> onTapCategoryItem;
  const HomeTabScreen({super.key, required this.onTapCategoryItem});

  @override
  State<HomeTabScreen> createState() => _HomeTabScreenState();
}

class _HomeTabScreenState extends State<HomeTabScreen> {
  @override
  Widget build(BuildContext context) {
    return AppLayout(
      header: Column(children: []),
      content: Container(
        padding: EdgeInsets.only(left: 35, top: 44, bottom: 0, right: 35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Rise and shine! It's breakfast time",
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppColors.orangeBase,
              ),
            ),
            SizedBox(height: 48),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: FoodCategoryDetails.visible.map((category) {
                return CategoryItemCard(
                  category: category,
                  onTap: () {
                    widget.onTapCategoryItem(category);
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 12),

            Divider(height: 1, color: AppColors.orangeBase),
          ],
        ),
      ),
    );
  }
}
