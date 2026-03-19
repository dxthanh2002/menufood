import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../bottom_navigation/root-tab-app-bar.dart';
import '../../theme/colors.dart';
import 'recipes_viewmodel.dart';
import 'widgets/recipe_card.dart';

class RecipesScreen extends StatelessWidget {
  const RecipesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RecipesViewModel(),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: RootTabAppBar(title: 'Recipes'),
        body: const RecipesContent(),
      ),
    );
  }
}

class RecipesContent extends StatelessWidget {
  const RecipesContent({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<RecipesViewModel>();

    return Column(
      children: [
        // Search Section
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search recipes, ingredients...',
                hintStyle: const TextStyle(
                  color: Color(0xFF94A3B8),
                  fontSize: 14,
                ), // slate-400
                prefixIcon: const Icon(
                  Icons.search,
                  color: Color(0xFF94A3B8),
                ), // slate-400
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 16,
                ),
              ),
            ),
          ),
        ),

        // Categories Section
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Categories',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'View all',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 60,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            itemCount: viewModel.categories.length,
            itemBuilder: (context, index) {
              final isSelected = viewModel.selectedCategoryIndex == index;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: GestureDetector(
                  onTap: () => viewModel.setSelectedCategory(index),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primary
                          : AppColors.softCream,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        viewModel.categories[index],
                        style: TextStyle(
                          color: isSelected
                              ? Colors.white
                              : AppColors.accentBrown,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        // Trending Recipes Section
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              const Text(
                'Trending Recipes',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
            itemCount: viewModel.recipes.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: RecipeCard(recipe: viewModel.recipes[index]),
              );
            },
          ),
        ),
      ],
    );
  }
}
