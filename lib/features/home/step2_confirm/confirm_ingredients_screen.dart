import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../theme/colors.dart';
import '../../../utils/responsive_util.dart';
import 'confirm_ingredients_viewmodel.dart';

class ConfirmIngredientsScreen extends StatelessWidget {
  const ConfirmIngredientsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ConfirmIngredientsViewModel(),
      child: const _ConfirmIngredientsContent(),
    );
  }
}

class _ConfirmIngredientsContent extends StatelessWidget {
  const _ConfirmIngredientsContent();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ConfirmIngredientsViewModel>();
    
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leadingWidth: 56 + 16,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: _circleIconButton(
            icon: Icons.arrow_back,
            onTap: () => Navigator.pop(context),
          ),
        ),
        title: Text(
          'Confirm Ingredients',
          style: GoogleFonts.inter(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
            fontSize: Responsive.scale(context, 18),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 16,
              bottom: Responsive.height(context, 0.2),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context),
                const SizedBox(height: 24),
                _buildSectionTitle('Detected Ingredients'),
                const SizedBox(height: 12),
                _buildIngredientsList(context, viewModel),
                const SizedBox(height: 32),
                _buildSectionTitle('Meal Type'),
                const SizedBox(height: 12),
                _buildMealTypes(context, viewModel),
                const SizedBox(height: 32),
                _buildSectionTitle('Cuisine'),
                const SizedBox(height: 12),
                _buildCuisineList(context, viewModel),
                const SizedBox(height: 32),
                _buildSectionTitle('Cooking Preferences'),
                const SizedBox(height: 12),
                _buildPreferences(context, viewModel),
              ],
            ),
          ),
          _buildBottomBar(context),
        ],
      ),
    );
  }

  Widget _circleIconButton({required IconData icon, required VoidCallback onTap}) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.transparent,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.textSecondary.withValues(alpha: 0.1)),
          ),
          child: Icon(icon, color: AppColors.textPrimary, size: 20),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Review and adjust',
          style: GoogleFonts.inter(
            fontSize: Responsive.scale(context, 26),
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Before finding the perfect recipes for you',
          style: GoogleFonts.inter(
            fontSize: Responsive.scale(context, 15),
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title.toUpperCase(),
      style: GoogleFonts.inter(
        fontSize: 11,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.5,
        color: AppColors.textSecondary.withOpacity(0.6),
      ),
    );
  }

  Widget _buildIngredientsList(BuildContext context, ConfirmIngredientsViewModel viewModel) {
    return Wrap(
      spacing: 8,
      runSpacing: 12,
      children: [
        ...viewModel.detectedIngredients.map((ingredient) => _buildIngredientChip(context, viewModel, ingredient)),
        _buildAddIngredientButton(context, viewModel),
      ],
    );
  }

  Widget _buildIngredientChip(BuildContext context, ConfirmIngredientsViewModel viewModel, String name) {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
      ),
      padding: const EdgeInsets.only(left: 14, right: 6),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(viewModel.getIngredientIcon(name), color: AppColors.primary, size: 20),
          const SizedBox(width: 8),
          Text(
            name,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(width: 6),
          GestureDetector(
            onTap: () => viewModel.removeIngredient(name),
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.close, size: 14, color: AppColors.textSecondary),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddIngredientButton(BuildContext context, ConfirmIngredientsViewModel viewModel) {
    return GestureDetector(
      onTap: () {
        // TODO: Show dialog to add ingredient
      },
      child: Container(
        height: 44,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: AppColors.textSecondary.withValues(alpha: 0.3),
            style: BorderStyle.solid,
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.add, color: AppColors.textSecondary, size: 20),
            const SizedBox(width: 8),
            Text(
              'Add ingredient manually',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMealTypes(BuildContext context, ConfirmIngredientsViewModel viewModel) {
    return Wrap(
      spacing: 8,
      runSpacing: 10,
      children: viewModel.mealTypes.map((type) {
        final isSelected = viewModel.selectedMealType == type;
        return GestureDetector(
          onTap: () => viewModel.selectMealType(type),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primary : Colors.white,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(
                color: isSelected ? AppColors.primary : AppColors.textSecondary.withValues(alpha: 0.1),
              ),
              boxShadow: isSelected ? [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                )
              ] : null,
            ),
            child: Text(
              type,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: isSelected ? Colors.white : AppColors.textPrimary,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildCuisineList(BuildContext context, ConfirmIngredientsViewModel viewModel) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: viewModel.cuisines.map((cuisine) {
          final isSelected = viewModel.selectedCuisine == cuisine;
          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () => viewModel.selectCuisine(cuisine),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary.withValues(alpha: 0.12) : Colors.white,
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(
                    color: isSelected ? AppColors.primary.withValues(alpha: 0.3) : AppColors.textSecondary.withValues(alpha: 0.1),
                    width: isSelected ? 1.5 : 1,
                  ),
                ),
                child: Text(
                  cuisine,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                    color: isSelected ? AppColors.primary : AppColors.textPrimary,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildPreferences(BuildContext context, ConfirmIngredientsViewModel viewModel) {
    return Wrap(
      spacing: 10,
      runSpacing: 12,
      children: viewModel.preferenceOptions.map((pref) {
        final isSelected = viewModel.selectedPreferences.contains(pref['name']);
        return GestureDetector(
          onTap: () => viewModel.togglePreference(pref['name']),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primary.withValues(alpha: 0.12) : Colors.white,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(
                color: isSelected ? AppColors.primary.withValues(alpha: 0.3) : AppColors.textSecondary.withValues(alpha: 0.1),
                width: isSelected ? 1.5 : 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  pref['icon'],
                  size: 18,
                  color: isSelected ? AppColors.primary : AppColors.textSecondary,
                ),
                const SizedBox(width: 8),
                Text(
                  pref['name'],
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                    color: isSelected ? AppColors.primary : AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.background.withValues(alpha: 0.98),
          border: Border(top: BorderSide(color: AppColors.textSecondary.withValues(alpha: 0.05))),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            )
          ],
        ),
        padding: EdgeInsets.fromLTRB(
          16, 
          16, 
          16, 
          16 + MediaQuery.of(context).padding.bottom
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                // TODO: Navigate to recipes screen with parameters
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 60),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                elevation: 4,
                shadowColor: AppColors.primary.withValues(alpha: 0.4),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Find Recipes',
                    style: GoogleFonts.inter(
                      fontSize: 17, 
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Icon(Icons.search_rounded, size: 24),
                ],
              ),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                // TODO: Skip preferences
              },
              child: Text(
                'Skip preferences',
                style: GoogleFonts.inter(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
