import 'package:flutter/material.dart';
import 'package:food_app/theme/app_colors.dart';

class AppLayout extends StatelessWidget {
  final Widget header;
  final Widget content;
  const AppLayout({super.key, required this.header, required this.content});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: AppColors.yellowBase,

        child: Column(
          children: [
            SafeArea(
              child: Container(
                width: double.infinity,
                height: 129,
                padding: EdgeInsets.symmetric(horizontal: 36),

                child: header,
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                //padding: EdgeInsets.symmetric(horizontal: 36),
                decoration: BoxDecoration(
                  color: AppColors.whiteBase,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: content,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
