import 'package:ai_menu_flutter/utils/format.dart';
import 'package:flutter/material.dart';
import '../../../models/recipe.dart';
import '../../../theme/colors.dart';

class RecipeCard extends StatelessWidget {
  final TrendingItem recipe;
  final VoidCallback? onTap;

  const RecipeCard({super.key, required this.recipe, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Stack
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(24),
                  ),
                  child: Image.network(
                    recipe.imageUrl!,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                // Bookmark button
                // Positioned(
                //   top: 12,
                //   right: 12,
                //   child: Container(
                //     decoration: BoxDecoration(
                //       color: Colors.white.withOpacity(0.8),
                //       shape: BoxShape.circle,
                //     ),
                //     child: IconButton(
                //       icon: const Icon(
                //         Icons.bookmark_outline,
                //         size: 20,
                //         color: Colors.black87,
                //       ),
                //       onPressed: () {},
                //     ),
                //   ),
                // ),
                // Popular Tag
                // if (recipe.isPopular)
                //   Positioned(
                //     bottom: 12,
                //     left: 12,
                //     child: Container(
                //       padding: const EdgeInsets.symmetric(
                //         horizontal: 12,
                //         vertical: 4,
                //       ),
                //       decoration: BoxDecoration(
                //         color: AppColors.primary.withOpacity(0.9),
                //         borderRadius: BorderRadius.circular(20),
                //       ),
                //       child: const Text(
                //         'POPULAR',
                //         style: TextStyle(
                //           color: Colors.white,
                //           fontSize: 10,
                //           fontWeight: FontWeight.bold,
                //           letterSpacing: 1.0,
                //         ),
                //       ),
                //     ),
                //   ),
              ],
            ),

            // Content
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipe.name!,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.schedule, size: 16, color: AppColors.primary),
                      const SizedBox(width: 4),
                      Text(
                        formatDuration(recipe.totalTimeMinutes),
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Icon(Icons.bolt, size: 16, color: AppColors.primary),
                      const SizedBox(width: 4),
                      Text(
                        capitalize(recipe.difficulty!) ?? "Medium",
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 13,
                        ),
                      ),
                      const Spacer(),
                      const Icon(Icons.star, size: 16, color: Colors.amber),
                      const SizedBox(width: 4),
                      Text(
                        recipe.score.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                          fontSize: 13,
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
