import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../theme/colors.dart';
import '../bottom_navigation/main_screen.dart';
import '../home/step3_result/step3_result_viewmodel.dart';
import 'detail_recipe_viewmodel.dart';
import 'detail_recipe_widgets.dart';

class DetailRecipeScreen extends StatelessWidget {
  const DetailRecipeScreen({super.key, required this.recipe});

  final Step3ResultRecipe recipe;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DetailRecipeViewModel(),
      child: _DetailRecipeContent(recipe: recipe),
    );
  }
}

class _DetailRecipeContent extends StatelessWidget {
  const _DetailRecipeContent({required this.recipe});

  final Step3ResultRecipe recipe;

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<DetailRecipeViewModel>();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          DetailRecipeHero(recipe: recipe),
          SliverToBoxAdapter(
            child: Transform.translate(
              offset: const Offset(0, -40),
              child: Container(
                decoration: const BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  ),
                ),
                padding: const EdgeInsets.fromLTRB(24, 50, 24, 24),
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
                        recipe.servings,
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
                          isChecked: viewModel.isIngredientChecked(index),
                          onChanged: () => viewModel.toggleIngredient(index),
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
        ],
      ),
      bottomNavigationBar: DetailRecipeBottomBar(
        onStartCooking: () {},
        onDestinationSelected: (index) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => MainScreen(initialIndex: index)),
            (_) => false,
          );
        },
      ),
    );
  }
}
