enum MainTab { home, menu, favorites, myOrder, help }

extension MainTabIndex on MainTab {
  /// Navigation indices are one-based so no page is represented by zero.
  int get pageIndex => index + 1;

  static MainTab fromPageIndex(int pageIndex) => MainTab.values[pageIndex - 1];
}
