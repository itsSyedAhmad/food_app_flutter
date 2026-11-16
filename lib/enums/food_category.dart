enum FoodCategory { none, snacks, meal, vegan, dessert, drinks }

extension FoodCategoryDetails on FoodCategory {
  /// `none` maps to -1; visible categories map to the zero-based UI indices.
  int get categoryIndex => this == FoodCategory.none ? -1 : index - 1;

  String get label => switch (this) {
    FoodCategory.none => '',
    FoodCategory.snacks => 'Snacks',
    FoodCategory.meal => 'Meal',
    FoodCategory.vegan => 'Vegan',
    FoodCategory.dessert => 'Dessert',
    FoodCategory.drinks => 'Drinks',
  };

  String get imageAsset => switch (this) {
    FoodCategory.none => '',
    FoodCategory.snacks => 'assets/images/snacks.png',
    FoodCategory.meal => 'assets/images/meals.png',
    FoodCategory.vegan => 'assets/images/vegan.png',
    FoodCategory.dessert => 'assets/images/dessert.png',
    FoodCategory.drinks => 'assets/images/drinks.png',
  };

  static FoodCategory fromIndex(int index) => index < 0
      ? FoodCategory.none
      : FoodCategory.values[index + 1];

  static const visible = [
    FoodCategory.snacks,
    FoodCategory.meal,
    FoodCategory.vegan,
    FoodCategory.dessert,
    FoodCategory.drinks,
  ];
}
