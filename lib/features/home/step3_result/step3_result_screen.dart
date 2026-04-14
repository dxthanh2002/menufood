import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../models/recipe.dart';
import '../../../navigation/widgets.dart';
import '../../../theme/colors.dart';
import 'step3_result_viewmodel.dart';
import 'step3_result_card.dart';

class Step3ResultScreen extends StatelessWidget {
  final List<SearchRecipeItem> recipes;
  const Step3ResultScreen({super.key, required this.recipes});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => Step3ResultViewModel(recipes),
      child: const _Step3ResultContent(),
    );
  }
}

class _Step3ResultContent extends StatelessWidget {
  const _Step3ResultContent();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<Step3ResultViewModel>();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: SizedBox(
                  height:
                      MediaQuery.of(context).padding.top +
                      AppNavActionButton.size +
                      AppNavActionButton.verticalPadding * 2,
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 28, 16, 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Dishes you can cook',
                        style: GoogleFonts.inter(
                          color: AppColors.accentBrown,
                          fontSize: 26,
                          fontWeight: FontWeight.w800,
                          height: 1.1,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Based on ingredients in your pantry',
                        style: GoogleFonts.inter(
                          color: AppColors.textSecondary,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
                sliver: SliverList.separated(
                  itemCount: viewModel.recipes.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 24),
                  itemBuilder: (context, index) {
                    final recipe = viewModel.recipes[index];
                    return ResultRecipeCard(recipe: recipe);
                  },
                ),
              ),
            ],
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.background,
                border: Border(
                  bottom: BorderSide(
                    color: AppColors.textSecondary.withValues(alpha: 0.08),
                  ),
                ),
              ),
              child: AppHeaderActionsWrapper(
                leading: AppNavActionButton(
                  icon: Icons.arrow_back_rounded,
                  onTap: () => Navigator.pop(context),
                  showShadow: false,
                  showBorder: false,
                ),
                title: 'MenuAI',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
