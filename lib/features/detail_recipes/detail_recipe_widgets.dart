import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme/colors.dart';
import '../bottom_navigation/main_screen.dart';
import '../home/step3_result/step3_result_viewmodel.dart';

class DetailRecipeHero extends StatelessWidget {
  const DetailRecipeHero({super.key, required this.recipe});

  final Step3ResultRecipe recipe;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 320,
      pinned: true,
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      leadingWidth: 64,
      leading: _HeroActionButton(
        icon: Icons.arrow_back_rounded,
        onTap: () => Navigator.pop(context),
      ),
      actions: const [
        _HeroActionButton(icon: Icons.favorite_border_rounded),
        SizedBox(width: 8),
        _HeroActionButton(icon: Icons.share_rounded),
        SizedBox(width: 16),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(recipe.imageUrl, fit: BoxFit.cover),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.5),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailRecipeHeroHeader extends StatelessWidget {
  const DetailRecipeHeroHeader({super.key, required this.recipe});

  final Step3ResultRecipe recipe;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 320,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(recipe.imageUrl, fit: BoxFit.cover),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.5),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _HeroActionButton(
                    icon: Icons.arrow_back_rounded,
                    onTap: () => Navigator.pop(context),
                  ),
                  const Spacer(),
                  const _HeroActionButton(icon: Icons.favorite_border_rounded),
                  const SizedBox(width: 8),
                  const _HeroActionButton(icon: Icons.share_rounded),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DetailRecipeInfoBar extends StatelessWidget {
  const DetailRecipeInfoBar({super.key, required this.recipe});

  final Step3ResultRecipe recipe;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(40),
      ),
      child: Row(
        children: [
          DetailRecipeInfoTile(
            icon: Icons.schedule_rounded,
            label: recipe.duration,
          ),
          const DetailRecipeInfoDivider(),
          DetailRecipeInfoTile(
            icon: Icons.bar_chart_rounded,
            label: recipe.difficulty,
          ),
          const DetailRecipeInfoDivider(),
          DetailRecipeInfoTile(
            icon: Icons.local_fire_department_rounded,
            label: recipe.calories,
          ),
        ],
      ),
    );
  }
}

class DetailRecipeInfoTile extends StatelessWidget {
  const DetailRecipeInfoTile({
    super.key,
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: AppColors.primary, size: 22),
          const SizedBox(height: 6),
          Text(
            label,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

class DetailRecipeInfoDivider extends StatelessWidget {
  const DetailRecipeInfoDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 34,
      margin: const EdgeInsets.symmetric(horizontal: 12),
      color: AppColors.primary.withValues(alpha: 0.2),
    );
  }
}

class DetailRecipeSectionTitle extends StatelessWidget {
  const DetailRecipeSectionTitle({
    super.key,
    required this.title,
    this.trailing,
  });

  final String title;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),
        ),
        trailing ?? const SizedBox.shrink(),
      ],
    );
  }
}

class DetailRecipeIngredientTile extends StatelessWidget {
  const DetailRecipeIngredientTile({
    super.key,
    required this.ingredient,
    required this.isChecked,
    required this.onChanged,
  });

  final RecipeIngredientItem ingredient;
  final bool isChecked;
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(40),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: onChanged,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            border: Border.all(
              color: isChecked
                  ? AppColors.primary.withValues(alpha: 0.35)
                  : AppColors.textSecondary.withValues(alpha: 0.14),
            ),
          ),
          child: Row(
            children: [
              Transform.translate(
                offset: const Offset(-15, 0),
                child: Checkbox(
                  value: isChecked,
                  onChanged: (_) => onChanged(),
                  activeColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        ingredient.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      ingredient.note,
                      textAlign: TextAlign.right,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DetailRecipeInstructionTile extends StatelessWidget {
  const DetailRecipeInstructionTile({
    super.key,
    required this.index,
    required this.instruction,
  });

  final int index;
  final RecipeInstructionStep instruction;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 34,
          height: 34,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
          ),
          child: Text(
            '$index',
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  instruction.title,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  instruction.description,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    height: 1.5,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class DetailRecipeBottomBar extends StatelessWidget {
  const DetailRecipeBottomBar({
    super.key,
    required this.onStartCooking,
    required this.onDestinationSelected,
  });

  final VoidCallback onStartCooking;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 12),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.94),
            border: Border(
              top: BorderSide(
                color: AppColors.textSecondary.withValues(alpha: 0.12),
              ),
            ),
          ),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: onStartCooking,
              icon: const Icon(Icons.play_circle_fill_rounded),
              label: Text(
                'Start Cooking Mode',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 58),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                elevation: 0,
              ),
            ),
          ),
        ),
        AppBottomNavigationBar(
          currentIndex: 1,
          onDestinationSelected: onDestinationSelected,
        ),
      ],
    );
  }
}

class _HeroActionButton extends StatelessWidget {
  const _HeroActionButton({required this.icon, this.onTap});

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.94),
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.textSecondary.withValues(alpha: 0.12),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Icon(icon, color: AppColors.accentBrown),
        ),
      ),
    );
  }
}
