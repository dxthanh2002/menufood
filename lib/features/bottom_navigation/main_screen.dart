import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/colors.dart';
import '../home/home_screen.dart';
import '../recipes/recipes_screen.dart';
import '../saved/saved_screen.dart';
import '../user_setting/user_setting_screen.dart';
import 'navigation_viewmodel.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key, this.initialIndex = 0});

  final int initialIndex;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NavigationViewModel(initialIndex: initialIndex),
      child: const MainContent(),
    );
  }
}

class MainContent extends StatelessWidget {
  const MainContent({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<NavigationViewModel>();

    const List<Widget> screens = [
      HomeScreen(),
      RecipesScreen(),
      SavedScreen(),
      UserSettingScreen(),
    ];

    return Scaffold(
      body: IndexedStack(index: viewModel.currentIndex, children: screens),
      bottomNavigationBar: AppBottomNavigationBar(
        currentIndex: viewModel.currentIndex,
        onDestinationSelected: viewModel.setIndex,
      ),
    );
  }
}

class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onDestinationSelected,
  });

  final int currentIndex;
  final ValueChanged<int> onDestinationSelected;

  static const List<NavigationDestination> _destinations = [
    NavigationDestination(
      icon: Icon(Icons.home_outlined),
      selectedIcon: Icon(Icons.home_rounded),
      label: 'Home',
    ),
    NavigationDestination(
      icon: Icon(Icons.restaurant_menu_outlined),
      selectedIcon: Icon(Icons.restaurant_menu_rounded),
      label: 'Recipes',
    ),
    NavigationDestination(
      icon: Icon(Icons.bookmark_border_rounded),
      selectedIcon: Icon(Icons.bookmark_rounded),
      label: 'Saved',
    ),
    NavigationDestination(
      icon: Icon(Icons.settings_outlined),
      selectedIcon: Icon(Icons.settings_rounded),
      label: 'Settings',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final navigationBackgroundColor = AppColors.surface.withValues(alpha: 0.96);

    return Container(
      decoration: BoxDecoration(
        color: navigationBackgroundColor,
        border: const Border(top: BorderSide(color: AppColors.navDivider)),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 18,
            offset: Offset(0, -6),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: NavigationBar(
          selectedIndex: currentIndex,
          onDestinationSelected: onDestinationSelected,
          backgroundColor: Colors.transparent,
          indicatorColor: navigationBackgroundColor,
          animationDuration: const Duration(milliseconds: 250),
          destinations: _destinations,
        ),
      ),
    );
  }
}
