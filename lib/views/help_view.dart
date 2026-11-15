import 'package:flutter/material.dart';
import 'package:food_app/views/tab_intro_view.dart';

class HelpTabScreen extends StatelessWidget {
  const HelpTabScreen({super.key});

  @override
  Widget build(BuildContext context) => const TabIntroView(
    title: 'Help',
    description: 'Find answers and get support with your order.',
    icon: Icons.help_outline,
  );
}
