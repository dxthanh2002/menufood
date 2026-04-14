import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../theme/colors.dart';
import '../home/step3_result/step3_result_viewmodel.dart';
import 'detail_recipe_viewmodel.dart';
import 'detail_recipe_widgets.dart';

class DetailRecipeScreen extends StatelessWidget {
  const DetailRecipeScreen({super.key, required this.recipeId});

  final String recipeId;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DetailRecipeViewModel()..loadRecipeDetails(recipeId),
      child: const _DetailRecipeContent(),
    );
  }
}

class _DetailRecipeContent extends StatelessWidget {
  const _DetailRecipeContent();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<DetailRecipeViewModel>();

    if (viewModel.loadingRecipeDetail) {
      return Scaffold(
        backgroundColor: AppColors.background,
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                color: AppColors.primary,
                strokeWidth: 3,
              ),
              SizedBox(height: 16),
              Text(
                'Loading recipe...',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      );
    }

    final recipe = viewModel.recipe;
    if (recipe == null) {
      return const SizedBox.shrink();
    }
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          const Positioned.fill(child: ColoredBox(color: AppColors.background)),
          const Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SizedBox(height: 320),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: DetailRecipeHeroBackground(recipe: recipe),
          ),
          Positioned.fill(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(top: 280),
              child: Material(
                color: Colors.white,
                clipBehavior: Clip.antiAlias,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(36),
                  topRight: Radius.circular(36),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 50, 24, 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        recipe.title,
                        style: GoogleFonts.inter(
                          fontSize: 31,
                          fontWeight: FontWeight.w800,
                          height: 1.05,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        recipe.description,
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          height: 1.5,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 24),
                      DetailRecipeInfoBar(recipe: recipe),
                      const SizedBox(height: 30),
                      DetailRecipeSectionTitle(
                        title: 'Ingredients',
                        trailing: Text(
                          recipe.servings.toString(),
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      ...List.generate(
                        recipe.ingredients.length,
                        (index) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: DetailRecipeIngredientTile(
                            ingredient: recipe.ingredients[index],
                            onTap: () {},
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),
                      const DetailRecipeSectionTitle(
                        title: 'Step-by-step instructions',
                      ),
                      const SizedBox(height: 18),
                      ...List.generate(
                        recipe.instructions.length,
                        (index) => Padding(
                          padding: EdgeInsets.only(
                            bottom: index == recipe.instructions.length - 1
                                ? 0
                                : 22,
                          ),
                          child: DetailRecipeInstructionTile(
                            index: index + 1,
                            instruction: recipe.instructions[index],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: const DetailRecipeHeroActions(),
          ),
        ],
      ),
    );
  }
}
