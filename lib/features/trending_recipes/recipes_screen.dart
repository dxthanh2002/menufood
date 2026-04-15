import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/app_service.dart';
import '../bottom_navigation/root-tab-app-bar.dart';
import '../../theme/colors.dart';
import 'recipes_viewmodel.dart';
import 'widgets/recipe_card.dart';

class TrendingRecipesScreen extends StatelessWidget {
  const TrendingRecipesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TrendingRecipesViewModel(),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: RootTabAppBar(title: 'Recipes'),
        body: const TrendingRecipesContent(),
      ),
    );
  }
}

class TrendingRecipesContent extends StatefulWidget {
  const TrendingRecipesContent({super.key});

  @override
  State<TrendingRecipesContent> createState() => _TrendingRecipesContentState();
}

class _TrendingRecipesContentState extends State<TrendingRecipesContent> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appService = context.watch<AppService>();
    if (!appService.initialized) {
      return const Scaffold(
        backgroundColor: AppColors.background,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: AppColors.primary),
              SizedBox(height: 16),
              Text(
                'Initializing...',
                style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
              ),
            ],
          ),
        ),
      );
    }

    final viewModel = context.watch<TrendingRecipesViewModel>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.loadTrendingRecipes();
    });

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
              controller: _searchController,
              onChanged: (value) => viewModel.searchRecipes(value),
              decoration: InputDecoration(
                hintText: 'Search recipes, ingredients...',
                hintStyle: const TextStyle(
                  color: Color(0xFF94A3B8),
                  fontSize: 14,
                ),
                prefixIcon: const Icon(Icons.search, color: Color(0xFF94A3B8)),
                suffixIcon: viewModel.searchResults.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, size: 20),
                        onPressed: () {
                          _searchController.clear();
                          viewModel.clearSearch();
                        },
                      )
                    : null,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 16,
                ),
              ),
            ),
          ),
        ),

        // Show search results or categories + trending
        Expanded(
          child: viewModel.isSearching || viewModel.searchResults.isNotEmpty
              ? _buildSearchResults(viewModel)
              : _buildMainContent(viewModel),
        ),
      ],
    );
  }

  Widget _buildSearchResults(TrendingRecipesViewModel viewModel) {
    if (viewModel.isSearching) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.primary),
      );
    }

    if (viewModel.searchResults.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 64, color: AppColors.textSecondary),
            SizedBox(height: 16),
            Text(
              'No recipes found',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
      itemCount: viewModel.searchResults.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 24),
          child: RecipeCard(
            recipe: viewModel.searchResults[index],
            onTap: () {
              // HAS onTap!
              viewModel.navigateToDetail(
                context,
                viewModel.searchResults[index].id!,
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildMainContent(TrendingRecipesViewModel viewModel) {
    if (viewModel.isLoadingTrending) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.primary),
      );
    }

    if (viewModel.trendingRecipes.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.restaurant, size: 64, color: AppColors.textSecondary),
            SizedBox(height: 16),
            Text(
              'No recipes available',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
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
            itemCount: viewModel.trendingRecipes.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: RecipeCard(
                  recipe: viewModel.trendingRecipes[index],
                  onTap: () {
                    viewModel.navigateToDetail(
                      context,
                      viewModel.trendingRecipes[index].id!,
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
