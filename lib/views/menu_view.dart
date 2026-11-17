import 'package:flutter/material.dart';
import 'package:food_app/enums/food_category.dart';
import 'package:food_app/components/category_item_card.dart';
import 'package:food_app/components/app_layout.dart';
import 'package:food_app/theme/app_colors.dart';

class MenuTabScreen extends StatefulWidget {
  final FoodCategory selectedCategory;
  const MenuTabScreen({super.key, required this.selectedCategory});

  @override
  State<MenuTabScreen> createState() => _MenuTabScreenState();
}

class _MenuTabScreenState extends State<MenuTabScreen> {
  late FoodCategory selectedCategory;

  @override
  void initState() {
    print("init state");
    selectedCategory = widget.selectedCategory;
    super.initState();
  }

  @override
  void dispose() {
    print("despose state");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      header: Column(children: []),
      content: Container(
        color: AppColors.orangeBase,
        child: Column(
          children: [
            // CategorySelector(),
            // Container(height: 200, width: double.infinity, color: Colors.green),
            Container(
              height: 120,
              width: double.infinity,
              color: AppColors.orangeBase,
              padding: EdgeInsets.only(left: 35, top: 15, bottom: 0, right: 35),
              child: LayoutBuilder(
                builder: (context, k) {
                  final eachWidth =
                      k.maxWidth / FoodCategoryDetails.visible.length;
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: FoodCategoryDetails.visible.map((category) {
                      return ClipPath(
                        clipper: CurvedTabClipper(),

                        child: Container(
                          color: category == selectedCategory
                              ? AppColors.whiteBase
                              : AppColors.orangeBase,
                          width: eachWidth,
                          padding: EdgeInsets.only(
                            left: 9,
                            top: 11,
                            bottom: 0,
                            right: 9,
                          ),
                          child: CategoryItemCard(
                            category: category,
                            onTap: () {
                              selectedCategory = category;
                              setState(() {});
                            },
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ),
            // SizedBox(
            //   width: 320,
            //   height: 350,
            //   child: CurvedContainer(
            //     color: Colors.green,
            //     child: const Center(
            //       child: Text('Meal', style: TextStyle(fontSize: 30)),
            //     ),
            //   ),
            // ),

            Expanded(
              child: Container(
                //width: double.infinity,

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
              ),
            ),
            // Container(
            //   height: 400,
            //   width: double.infinity,
            //   color: Colors.yellow,
            // ),
          ],
        ),
      ),
    );
  }
}

class CurvedTabClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final w = size.width;
    final h = size.height;

    final path = Path();

    // Top corner radius (UNCHANGED)
    final radius = 30.0.clamp(0.0, w / 2);

    // Top-left
    path.moveTo(radius, 0);

    // Top edge
    //path.lineTo(w - radius, 0);

    // Top-right rounded corner (UNCHANGED)
    path.quadraticBezierTo(w, 0, w, radius);

    // Right vertical side
    path.lineTo(w, h * 1);

    // Right side moves inward
    // path.cubicTo(w, h * 0.65, w * 1.25, h * 0.65, w * 1.5, h * 1);

    // // Right bottom curve moves OUTWARD
    // path.cubicTo(w * 0.84, h * 0.90, w * 0.93, h, w, h);

    // Bottom edge
    path.lineTo(0, h);

    // Left bottom curve moves OUTWARD
    // path.cubicTo(w * 0.07, h, w * 0.16, h * 0.90, w * 0.16, h * 0.76);

    // // Left side moves outward to original edge
    // path.cubicTo(w * 0.16, h * 0.65, 0, h * 0.65, 0, h * 0.50);

    // Left vertical side
    path.lineTo(0, radius);

    // Top-left rounded corner (UNCHANGED)
    path.quadraticBezierTo(0, 0, radius, 0);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CurvedTabClipper oldClipper) {
    return false;
  }
}
