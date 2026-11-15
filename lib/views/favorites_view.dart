import 'package:flutter/material.dart';
import 'package:food_app/views/tab_intro_view.dart';

class FavoritesTabScreen extends StatelessWidget {
  const FavoritesTabScreen({super.key});

  @override
  Widget build(BuildContext context) => const TabIntroView(
    title: 'Favorites',
    description: 'Your favorite meals will be easy to find here.',
    icon: Icons.favorite_border,
  );
}
