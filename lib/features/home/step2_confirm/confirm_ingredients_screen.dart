import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../navigation/routes.dart';
import '../../../theme/colors.dart';
import '../../../utils/responsive_util.dart';
import 'confirm_ingredients_viewmodel.dart';

class ConfirmIngredientsScreen extends StatelessWidget {
  const ConfirmIngredientsScreen({super.key, this.imagePath});

  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ConfirmIngredientsViewModel(),
      child: _ConfirmIngredientsContent(imagePath: imagePath),
    );
  }
}

class _ConfirmIngredientsContent extends StatelessWidget {
  const _ConfirmIngredientsContent({this.imagePath});

  final String? imagePath;

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
                if (imagePath != null) ...[
                  _buildSectionTitle('Selected Photo'),
                  const SizedBox(height: 12),
                  _buildSelectedImagePreview(),
                  const SizedBox(height: 32),
                ],
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

  Widget _circleIconButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.transparent,
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.textSecondary.withValues(alpha: 0.1),
            ),
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

  Widget _buildSelectedImagePreview() {
    if (imagePath == null) {
      return const SizedBox.shrink();
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: AspectRatio(
        aspectRatio: 4 / 3,
        child: Image.file(File(imagePath!), fit: BoxFit.cover),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title.toUpperCase(),
      style: GoogleFonts.inter(
        fontSize: 11,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.5,
        color: AppColors.textSecondary.withValues(alpha: 0.6),
      ),
    );
  }

  Widget _buildIngredientsList(
    BuildContext context,
    ConfirmIngredientsViewModel viewModel,
  ) {
    return Wrap(
      spacing: 8,
      runSpacing: 12,
      children: [
        ...viewModel.detectedIngredients.map(
          (ingredient) => _buildIngredientChip(context, viewModel, ingredient),
        ),
        _buildAddIngredientButton(context, viewModel),
      ],
    );
  }

  Widget _buildIngredientChip(
    BuildContext context,
    ConfirmIngredientsViewModel viewModel,
    String name,
  ) {
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
          Icon(
            viewModel.getIngredientIcon(name),
            color: AppColors.primary,
            size: 20,
          ),
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
              child: const Icon(
                Icons.close,
                size: 14,
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddIngredientButton(
    BuildContext context,
    ConfirmIngredientsViewModel viewModel,
  ) {
    return GestureDetector(
      onTap: () {
        _showAddIngredientSheet(context, viewModel);
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

  Future<void> _showAddIngredientSheet(
    BuildContext context,
    ConfirmIngredientsViewModel viewModel,
  ) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withValues(alpha: 0.4),
      builder: (_) => _AddIngredientBottomSheet(
        viewModel: viewModel,
        buildQuickAddLabel: _buildQuickAddLabel,
      ),
    );
  }

  String _buildQuickAddLabel(String ingredient) => switch (ingredient) {
    'Salt' => 'Salt',
    'Pepper' => 'Pepper',
    'Garlic' => 'Garlic',
    'Olive Oil' => 'Olive Oil',
    'Lemon' => 'Lemon',
    _ => ingredient,
  };

  Widget _buildMealTypes(
    BuildContext context,
    ConfirmIngredientsViewModel viewModel,
  ) {
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
                color: isSelected
                    ? AppColors.primary
                    : AppColors.textSecondary.withValues(alpha: 0.1),
              ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : null,
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

  Widget _buildCuisineList(
    BuildContext context,
    ConfirmIngredientsViewModel viewModel,
  ) {
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 22,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primary.withValues(alpha: 0.12)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.primary.withValues(alpha: 0.3)
                        : AppColors.textSecondary.withValues(alpha: 0.1),
                    width: isSelected ? 1.5 : 1,
                  ),
                ),
                child: Text(
                  cuisine,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                    color: isSelected
                        ? AppColors.primary
                        : AppColors.textPrimary,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildPreferences(
    BuildContext context,
    ConfirmIngredientsViewModel viewModel,
  ) {
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
              color: isSelected
                  ? AppColors.primary.withValues(alpha: 0.12)
                  : Colors.white,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(
                color: isSelected
                    ? AppColors.primary.withValues(alpha: 0.3)
                    : AppColors.textSecondary.withValues(alpha: 0.1),
                width: isSelected ? 1.5 : 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  pref['icon'],
                  size: 18,
                  color: isSelected
                      ? AppColors.primary
                      : AppColors.textSecondary,
                ),
                const SizedBox(width: 8),
                Text(
                  pref['name'],
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                    color: isSelected
                        ? AppColors.primary
                        : AppColors.textPrimary,
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
          border: Border(
            top: BorderSide(
              color: AppColors.textSecondary.withValues(alpha: 0.05),
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        padding: EdgeInsets.fromLTRB(
          16,
          16,
          16,
          16 + MediaQuery.of(context).padding.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.step3Result);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 60),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
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
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  // TODO: Skip preferences
                },
                style: TextButton.styleFrom(
                  minimumSize: const Size(double.infinity, 60),
                ),
                child: Text(
                  'Skip preferences',
                  style: GoogleFonts.inter(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AddIngredientBottomSheet extends StatefulWidget {
  const _AddIngredientBottomSheet({
    required this.viewModel,
    required this.buildQuickAddLabel,
  });

  final ConfirmIngredientsViewModel viewModel;
  final String Function(String ingredient) buildQuickAddLabel;

  @override
  State<_AddIngredientBottomSheet> createState() =>
      _AddIngredientBottomSheetState();
}

class _AddIngredientBottomSheetState extends State<_AddIngredientBottomSheet> {
  final TextEditingController _ingredientController = TextEditingController();
  final Set<String> _selectedQuickAdds = <String>{};
  String? _validationMessage;

  bool get _canSubmit =>
      _ingredientController.text.trim().isNotEmpty ||
      _selectedQuickAdds.isNotEmpty;

  @override
  void initState() {
    super.initState();
    _ingredientController.addListener(_handleTextChanged);
  }

  @override
  void dispose() {
    _ingredientController
      ..removeListener(_handleTextChanged)
      ..dispose();
    super.dispose();
  }

  void _handleTextChanged() {
    if (!mounted) return;
    setState(() {
      _validationMessage = null;
    });
  }

  void _toggleQuickAdd(String value) {
    setState(() {
      _validationMessage = null;
      if (_selectedQuickAdds.contains(value)) {
        _selectedQuickAdds.remove(value);
      } else {
        _selectedQuickAdds.add(value);
      }
    });
  }

  void _submitIngredient() {
    final String ingredientName = _ingredientController.text.trim();
    final Set<String> normalizedIngredients = _selectedQuickAdds
        .map((ingredient) => ingredient.trim())
        .where((ingredient) => ingredient.isNotEmpty)
        .toSet();

    if (ingredientName.isNotEmpty) {
      normalizedIngredients.add(ingredientName);
    }

    if (normalizedIngredients.isEmpty) {
      return;
    }

    int addedCount = 0;
    for (final ingredient in normalizedIngredients) {
      if (widget.viewModel.addIngredient(ingredient)) {
        addedCount++;
      }
    }

    if (addedCount > 0) {
      FocusScope.of(context).unfocus();
      Navigator.of(context).pop();
      return;
    }

    setState(() {
      _validationMessage = 'Selected ingredients already in the list.';
    });
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return AnimatedPadding(
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOut,
      padding: EdgeInsets.only(bottom: bottomInset),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
        child: SafeArea(
          top: false,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 48,
                    height: 6,
                    decoration: BoxDecoration(
                      color: AppColors.textSecondary.withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Add Ingredient',
                  style: GoogleFonts.inter(
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _ingredientController,
                  autofocus: true,
                  textCapitalization: TextCapitalization.words,
                  textInputAction: TextInputAction.done,
                  onSubmitted: (_) => _submitIngredient(),
                  decoration: InputDecoration(
                    hintText: 'e.g., Garlic, Broccoli...',
                    hintStyle: GoogleFonts.inter(
                      color: AppColors.textSecondary.withValues(alpha: 0.6),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    filled: true,
                    fillColor: AppColors.background,
                    prefixIcon: Icon(
                      Icons.search_rounded,
                      color: AppColors.textSecondary.withValues(alpha: 0.5),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 18,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(22),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(22),
                      borderSide: BorderSide(
                        color: AppColors.primary.withValues(alpha: 0.2),
                        width: 1.5,
                      ),
                    ),
                  ),
                  style: GoogleFonts.inter(
                    color: AppColors.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 28),
                Text(
                  'QUICK ADD',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.3,
                    color: AppColors.textSecondary.withValues(alpha: 0.75),
                  ),
                ),
                const SizedBox(height: 14),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: widget.viewModel.quickAddIngredients.map((item) {
                    final bool isSelected = _selectedQuickAdds.contains(item);
                    return GestureDetector(
                      onTap: () => _toggleQuickAdd(item),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 9,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primary
                              : AppColors.background,
                          borderRadius: BorderRadius.circular(999),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.primary
                                : Colors.transparent,
                          ),
                        ),
                        child: Text(
                          widget.buildQuickAddLabel(item),
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: isSelected
                                ? Colors.white
                                : AppColors.textPrimary,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 28),
                if (_validationMessage != null) ...[
                  Text(
                    _validationMessage!,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.red.shade400,
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _canSubmit ? _submitIngredient : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: AppColors.primary.withValues(
                        alpha: 0.45,
                      ),
                      disabledForegroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      'Add to List',
                      style: GoogleFonts.inter(
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
