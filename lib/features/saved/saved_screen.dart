// lib/features/saved/saved_screen.dart
import 'package:ai_menu_flutter/features/saved/saved_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/app_service.dart';
import '../bottom_navigation/root-tab-app-bar.dart';
import '../../models/recipe.dart';
import '../../theme/colors.dart';
import '../../utils/responsive_util.dart';
import '../../navigation/routes.dart';
import 'widgets/saved_recipe_card.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({super.key, this.showBackButton = false});

  final bool showBackButton;

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SavedRecipesViewModel(),
      child: _SavedScreenContent(showBackButton: widget.showBackButton),
    );
  }
}

class _SavedScreenContent extends StatelessWidget {
  final bool showBackButton;
  const _SavedScreenContent({required this.showBackButton});

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
    final viewModel = context.watch<SavedRecipesViewModel>();

    final isDesktop = Responsive.isDesktop(context);
    final isTablet = Responsive.isTablet(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: RootTabAppBar(
        title: 'Saved Recipes',
        leading: showBackButton
            ? RootTabAppBar.buildActionButton(
                icon: const Icon(
                  Icons.arrow_back_rounded,
                  color: AppColors.accentBrown,
                ),
                onPressed: () => Navigator.maybePop(context),
              )
            : null,
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          _buildCategories(viewModel),
          Expanded(
            child: viewModel.isLoading
                ? const Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  )
                : _buildRecipeList(context, viewModel, isDesktop, isTablet),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
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
        child: const TextField(
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Search saved recipes',
            hintStyle: TextStyle(color: Color(0xFF94A3B8), fontSize: 14),
            prefixIcon: Icon(Icons.search, color: Color(0xFF94A3B8)),
            contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          ),
        ),
      ),
    );
  }

  Widget _buildCategories(SavedRecipesViewModel viewModel) {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        itemCount: viewModel.categories.length,
        itemBuilder: (context, index) {
          final category = viewModel.categories[index];
          final isSelected = viewModel.selectedCategory == category;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: GestureDetector(
              onTap: () => viewModel.selectCategory(category),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : AppColors.softCream,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    category,
                    style: TextStyle(
                      color: isSelected ? Colors.white : AppColors.accentBrown,
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
    );
  }

  Widget _buildRecipeList(
    BuildContext context,
    SavedRecipesViewModel viewModel,
    bool isDesktop,
    bool isTablet,
  ) {
    final recipes = viewModel.filteredRecipes;

    if (recipes.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite_border,
              size: 64,
              color: AppColors.textSecondary,
            ),
            SizedBox(height: 16),
            Text(
              'No saved recipes yet',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.textSecondary,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Save your favorite recipes to see them here',
              style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
            ),
          ],
        ),
      );
    }

    if (isDesktop || isTablet) {
      return GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: isDesktop ? 4 : (isTablet ? 2 : 1),
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.85,
        ),
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          final data = recipes[index];
          return _buildGridCard(
            context,
            data['recipe'] as Recipe,
            data['typeTag'] as String,
            viewModel,
          );
        },
      );
    } else {
      return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          final data = recipes[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: SavedRecipeCard(
              recipe: data['recipe'] as Recipe,
              typeTag: data['typeTag'] as String,
              onTap: () =>
                  viewModel.navigateToDetail(context, data['recipe'] as Recipe),
              onFavoriteTap: () {
                viewModel.removeSavedRecipe((data['recipe'] as Recipe).id);
              },
            ),
          );
        },
      );
    }
  }

  Widget _buildGridCard(
    BuildContext context,
    Recipe recipe,
    String tag,
    SavedRecipesViewModel viewModel,
  ) {
    return InkWell(
      onTap: () => viewModel.navigateToDetail(context, recipe),
      borderRadius: BorderRadius.circular(24),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.softCream, width: 1),
          boxShadow: const [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(recipe.imageUrl, fit: BoxFit.cover),
                    Positioned(
                      top: 12,
                      right: 12,
                      child: CircleAvatar(
                        backgroundColor: Colors.white70,
                        radius: 18,
                        child: IconButton(
                          iconSize: 18,
                          icon: const Icon(
                            Icons.favorite,
                            color: AppColors.primary,
                          ),
                          onPressed: () {
                            viewModel.removeSavedRecipe(recipe.id);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipe.title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.accentBrown,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          tag,
                          style: const TextStyle(
                            color: AppColors.primary,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.schedule,
                        size: 12,
                        color: Color(0xFF8E847C),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        recipe.duration,
                        style: const TextStyle(
                          color: Color(0xFF8E847C),
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
