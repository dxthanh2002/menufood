import 'package:flutter/material.dart';
import '../bottom_navigation/root-tab-app-bar.dart';
import '../../models/recipe.dart';
import '../../theme/colors.dart';
import '../../utils/responsive_util.dart';
import 'widgets/saved_recipe_card.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({super.key, this.showBackButton = false});

  final bool showBackButton;

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  final List<String> categories = [
    'All',
    'Quick',
    'Healthy',
    'Vegetarian',
    'Desserts',
  ];
  String selectedCategory = 'All';

  // Mock data for the saved recipes
  final List<Map<String, dynamic>> savedRecipes = [
    {
      'recipe': Recipe(
        id: '1',
        title: 'Tomato Egg Stir Fry',
        imageUrl:
            'https://lh3.googleusercontent.com/aida-public/AB6AXuBRLjuHmRk18TtUed0gfp6S-obAXPJtzWHyfiVyAECXp9hpxWO3D4QiFgplV79W5w8hDeRXDT3nK7dXefQJ5jaEHKoTB3D4DyRvUpPQONyrhzsYXKzCI_FF_NZgKI7fVMB4k1KZUvm8_hwZDNjmzlPUzullbeFbQSujtyk2dWV8_o-PjO82HMcKrg7a40ffHNSM3eaBQRLJrq05pvzMOg6-15FR_n6rN2G314x8q9FtesQreVUwOC8nzeUlnD5aLMchWJYp5k0r5cw',
        duration: '15 mins',
        difficulty: 'Easy',
        rating: 4.5,
      ),
      'typeTag': 'Dinner',
    },
    {
      'recipe': Recipe(
        id: '2',
        title: 'Mediterranean Salad',
        imageUrl:
            'https://lh3.googleusercontent.com/aida-public/AB6AXuBiZawCjBgv8atWtOjkVP1gS0fBiVDxUgFU4o3IkqR5_ivA4x4HiwvO0LMrVzS1H95f8MKyvxnyZDlYyk_TWkOxXW-B9PYxBpId1mpBSrM4v-VV55Ea_014teczMqeLZu-4koI6jT8jNGZYwOv8wtlsiBfyC6QjHGDiMBX54izcT4o-vKYtqfm1AeFH3WtTxPtPiQM2QtsW0lAS6m6eRYkZMXgcinb9MkhWTEHnTBMdsuerhns06rQC4NGoka0is4QHMFTZn0Tpc0A',
        duration: '10 mins',
        difficulty: 'Easy',
        rating: 4.8,
      ),
      'typeTag': 'Healthy',
    },
    {
      'recipe': Recipe(
        id: '3',
        title: 'Lemon Garlic Salmon',
        imageUrl:
            'https://lh3.googleusercontent.com/aida-public/AB6AXuB33GeMAE1MYAo8ahXAc7A3aXMgMngxak6nySpz7t-UC3XkCcWh8t_rsd6mN-EaRbGo28MSju3knqvz8MOLeBWINd3wvyBEFLDNtGfUFbrhyPotSljj2jGu11irKPc5s_p2RhwBTv9uCfGpDHW5EavjcUYn0aWCVMekHoT659sy_I7-pzV82d3uaCe9kkd1EAdyHq_KiryOWIADap3ulqTiH5QQbDH_IZfUcomSXyB071bXt5_Y2sfJLo_VACEbbEs5wXMe_d1ZBGY',
        duration: '25 mins',
        difficulty: 'Medium',
        rating: 4.9,
      ),
      'typeTag': 'High Protein',
    },
    {
      'recipe': Recipe(
        id: '4',
        title: 'Glazed Baked Donuts',
        imageUrl:
            'https://lh3.googleusercontent.com/aida-public/AB6AXuBfxoJYtsumTskA4koLkT1k70AArgfDgVNuQ3AC4AJY9m-PJFsGDH_eLKiknJX6aVI-ntqhF58pl6HlMqaHmPLMO9gNpzSQ46uviXmaMENEzHAt9ufuzzfy-e6DOHM4YkIPeYI3nLcVMaeXzEdGQmTTalZjPyYVKHYuUEMnnHyKDS5ULd0D6SeKAwe-aDz65B6bD-HuQGvdTT9jDN052DdmkNTWiihwQ5XyJ2xgwRMS484Dwc4qqr27GD1WulR9Pqn0YztItu_jrhU',
        duration: '45 mins',
        difficulty: 'Medium',
        rating: 4.7,
      ),
      'typeTag': 'Dessert',
    },
  ];

  @override
  Widget build(BuildContext context) {
    bool isDesktop = Responsive.isDesktop(context);
    bool isTablet = Responsive.isTablet(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: RootTabAppBar(
        title: 'Saved Recipes',
        leading: widget.showBackButton
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
          _buildCategories(),
          Expanded(child: _buildRecipeList(isDesktop, isTablet)),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: AppColors.softCream.withOpacity(0.5),
          borderRadius: BorderRadius.circular(16),
        ),
        child: const TextField(
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Search saved recipes',
            hintStyle: TextStyle(
              color: Color(0xFF8E847C),
            ), // Keeping descriptive color
            icon: Icon(Icons.search, color: AppColors.primary),
          ),
        ),
      ),
    );
  }

  Widget _buildCategories() {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = selectedCategory == category;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: GestureDetector(
              onTap: () => setState(() => selectedCategory = category),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 8,
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

  Widget _buildRecipeList(bool isDesktop, bool isTablet) {
    if (isDesktop || isTablet) {
      // Use GridView for larger screens
      return GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: isDesktop ? 4 : (isTablet ? 2 : 1),
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.85,
        ),
        itemCount: savedRecipes.length,
        itemBuilder: (context, index) {
          final data = savedRecipes[index];
          return _buildGridCard(
            data['recipe'] as Recipe,
            data['typeTag'] as String,
          );
        },
      );
    } else {
      // Use ListView for mobile (Horizontal cards)
      return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: savedRecipes.length,
        itemBuilder: (context, index) {
          final data = savedRecipes[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: SavedRecipeCard(
              recipe: data['recipe'] as Recipe,
              typeTag: data['typeTag'] as String,
              onTap: () {},
              onFavoriteTap: () {},
            ),
          );
        },
      );
    }
  }

  Widget _buildGridCard(Recipe recipe, String tag) {
    return Container(
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
                        onPressed: () {},
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
    );
  }
}
