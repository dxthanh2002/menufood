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

    final List<Widget> screens = [
      const HomeScreen(),
      const RecipesScreen(),
      const SavedScreen(),
      const UserSettingScreen(),
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

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 10,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: onDestinationSelected,
        backgroundColor: AppColors.surface,
        indicatorColor: Colors.transparent,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_rounded), label: 'Home'),
          NavigationDestination(
            icon: Icon(Icons.soup_kitchen_rounded),
            label: 'Recipes',
          ),
          NavigationDestination(
            icon: Icon(Icons.bookmark_rounded),
            label: 'Saved',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_rounded),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
