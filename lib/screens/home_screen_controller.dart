import 'package:flutter/material.dart';
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
  int _selectedPageIndex = 0;
  int _selectedCategoryIndex = -1;

  void onChangeCategoryIndex({required int index}) {
    _selectedCategoryIndex = index;
    _selectedPageIndex = 1;
    setState(() {});
  }

  List<Widget> get _screens => [
    HomeTabScreen(
      onTapCategoryItem: (int index) {
        onChangeCategoryIndex(index: index);
      },
    ),
    MenuTabScreen(selectedIndex: _selectedCategoryIndex),
    FavoritesTabScreen(),
    OrdersTabScreen(),
    HelpTabScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    print(_selectedCategoryIndex);
    return Scaffold(
      body: _screens[_selectedPageIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        child: SizedBox(
          height: 61,
          child: MediaQuery.removePadding(
            context: context,
            removeBottom: true,
            child: BottomNavigationBar(
              currentIndex: _selectedPageIndex,
              onTap: (index) => setState(() {
                _selectedPageIndex = index;
                _selectedCategoryIndex = -1;
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
