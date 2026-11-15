import 'package:flutter/material.dart';
import 'package:food_app/views/tab_intro_view.dart';

class OrdersTabScreen extends StatelessWidget {
  const OrdersTabScreen({super.key});

  @override
  Widget build(BuildContext context) => const TabIntroView(
    title: 'My Orders',
    description: 'View your recent orders and track their progress.',
    icon: Icons.receipt_long_outlined,
  );
}
