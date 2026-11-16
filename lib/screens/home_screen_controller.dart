import 'package:flutter/material.dart';
import 'package:food_app/enums/food_category.dart';
import 'package:food_app/enums/main_tab.dart';
import 'package:food_app/theme/app_colors.dart';
import 'package:food_app/views/favorites_view.dart';
import 'package:food_app/views/help_view.dart';
import 'package:food_app/views/home_view.dart';
import 'package:food_app/views/menu_view.dart';
import 'package:food_app/views/orders_view.dart';

class HomeScreenController extends StatefulWidget {
  const HomeScreenController({super.key});

  @override
  State<HomeScreenController> createState() => _HomeScreenControllerState();
}

class _HomeScreenControllerState extends State<HomeScreenController> {
  MainTab _selectedPage = MainTab.home;
  FoodCategory _selectedCategory = FoodCategory.none;

  void onChangeCategory({required FoodCategory category}) {
    _selectedCategory = category;
    _selectedPage = MainTab.menu;
    setState(() {});
  }

  List<Widget> get _screens => [
    HomeTabScreen(
      onTapCategoryItem: (FoodCategory category) {
        onChangeCategory(category: category);
      },
    ),
    MenuTabScreen(selectedCategory: _selectedCategory),
    FavoritesTabScreen(),
    OrdersTabScreen(),
    HelpTabScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedPage.pageIndex - 1],
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        child: SizedBox(
          height: 61,
          child: MediaQuery.removePadding(
            context: context,
            removeBottom: true,
            child: BottomNavigationBar(
              currentIndex: _selectedPage.pageIndex - 1,
              onTap: (index) => setState(() {
                _selectedPage = MainTabIndex.fromPageIndex(index + 1);
                _selectedCategory = FoodCategory.none;
              }),
              type: BottomNavigationBarType.fixed,
              selectedItemColor: AppColors.whiteBase,
              unselectedItemColor: AppColors.black2,
              backgroundColor: AppColors.orangeBase,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.restaurant_menu),
                  label: 'Menu',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_border),
                  label: 'Favorites',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.receipt_long_outlined),
                  label: 'My Orders',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.help_outline),
                  label: 'Help',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
