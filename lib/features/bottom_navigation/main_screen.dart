import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/colors.dart';
import '../home/home_screen.dart';
import '../recipes/recipes_screen.dart';
import '../saved/saved_screen.dart';
import '../history/history_screen.dart';
import 'navigation_viewmodel.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NavigationViewModel(),
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
      const HistoryScreen(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: viewModel.currentIndex,
        children: screens,
      ),
      bottomNavigationBar: Container(
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
          selectedIndex: viewModel.currentIndex,
          onDestinationSelected: viewModel.setIndex,
          backgroundColor: AppColors.surface,
          indicatorColor: Colors.transparent, // Disable default pill indicator for custom look
          destinations: [
            _buildNavigationDestination(
              context: context,
              index: 0,
              currentIndex: viewModel.currentIndex,
              icon: Icons.home_rounded,
              label: 'Home',
            ),
            _buildNavigationDestination(
              context: context,
              index: 1,
              currentIndex: viewModel.currentIndex,
              icon: Icons.soup_kitchen_rounded,
              label: 'Recipes',
            ),
            _buildNavigationDestination(
              context: context,
              index: 2,
              currentIndex: viewModel.currentIndex,
              icon: Icons.bookmark_rounded,
              label: 'Saved',
            ),
            _buildNavigationDestination(
              context: context,
              index: 3,
              currentIndex: viewModel.currentIndex,
              icon: Icons.history_rounded,
              label: 'History',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationDestination({
    required BuildContext context,
    required int index,
    required int currentIndex,
    required IconData icon,
    required String label,
  }) {
    return NavigationDestination(
      icon: Icon(icon),
      label: label,
    );
  }
}
