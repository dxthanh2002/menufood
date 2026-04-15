import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/app_service.dart';
import '../../utils/console.dart';
import '../bottom_navigation/root-tab-app-bar.dart';
import '../bottom_navigation/navigation_viewmodel.dart';
import '../../theme/colors.dart';
import '../../utils/responsive_util.dart';
import 'home_viewmodel.dart';
import '../../navigation/routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeViewModel(),
      child: Consumer<HomeViewModel>(
        builder: (context, viewModel, child) {
          final appService = context.watch<AppService>();
          if (!appService.initialized) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
                strokeWidth: 2,
              ),
            );
          }

          WidgetsBinding.instance.addPostFrameCallback((_) {
            viewModel.loadSuggestion();
          });
          return Scaffold(
            backgroundColor: AppColors.background,
            appBar: const RootTabAppBar(title: 'MenuAI'),
            body: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: Responsive.height(context, 0.03),
                                bottom: Responsive.height(context, 0.02),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: Responsive.width(
                                        context,
                                        0.08,
                                      ),
                                    ),
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        'Scan your ingredients',
                                        style: TextStyle(
                                          fontSize: Responsive.scale(
                                            context,
                                            26,
                                          ),
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.textPrimary,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: Responsive.height(context, 0.005),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: Responsive.width(
                                        context,
                                        0.12,
                                      ),
                                    ),
                                    child: Text(
                                      "Point your camera at what's in your fridge",
                                      style: TextStyle(
                                        fontSize: Responsive.scale(context, 14),
                                        color: AppColors.textSecondary,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  SizedBox(
                                    height: Responsive.height(context, 0.03),
                                  ),

                                  // Camera Button with Glow Effect
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(
                                        width: Responsive.scale(
                                          context,
                                          140,
                                        ).clamp(110.0, 160.0).toDouble(),
                                        height: Responsive.scale(
                                          context,
                                          140,
                                        ).clamp(110.0, 160.0).toDouble(),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color: AppColors.primary
                                                  .withOpacity(0.3),
                                              blurRadius: Responsive.scale(
                                                context,
                                                40,
                                              ),
                                              spreadRadius: Responsive.scale(
                                                context,
                                                10,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Hero(
                                        tag: 'camera_button',
                                        child: Material(
                                          color: AppColors.primary,
                                          shape: const CircleBorder(),
                                          elevation: 6,
                                          shadowColor: AppColors.primary
                                              .withValues(alpha: 0.4),
                                          child: GestureDetector(
                                            behavior: HitTestBehavior.opaque,
                                            onTap: () {
                                              Navigator.pushNamed(
                                                context,
                                                Routes.scanner,
                                              );
                                            },
                                            child: SizedBox(
                                              width: Responsive.scale(
                                                context,
                                                100,
                                              ).clamp(80.0, 120.0).toDouble(),
                                              height: Responsive.scale(
                                                context,
                                                100,
                                              ).clamp(80.0, 120.0).toDouble(),
                                              child: Icon(
                                                Icons.photo_camera_rounded,
                                                size: Responsive.scale(
                                                  context,
                                                  50,
                                                ).clamp(40.0, 65.0).toDouble(),
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  SizedBox(
                                    height: Responsive.height(context, 0.03),
                                  ),

                                  // Upload Button
                                  OutlinedButton.icon(
                                    onPressed: () =>
                                        viewModel.pickImageToConfirm(context),
                                    icon: Icon(
                                      Icons.upload_file_rounded,
                                      size: Responsive.scale(context, 20),
                                    ),
                                    label: Text(
                                      'Upload a photo',
                                      style: TextStyle(
                                        fontSize: Responsive.scale(context, 14),
                                      ),
                                    ),
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: AppColors.primary,
                                      side: BorderSide(
                                        color: AppColors.primary.withOpacity(
                                          0.2,
                                        ),
                                        width: 2,
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: Responsive.width(
                                          context,
                                          0.08,
                                        ),
                                        vertical: Responsive.height(
                                          context,
                                          0.012,
                                        ),
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          Responsive.scale(context, 30),
                                        ),
                                      ),
                                      textStyle: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // Discovery Section
                          Container(
                            padding: EdgeInsets.fromLTRB(
                              Responsive.width(context, 0.06),
                              Responsive.height(context, 0.025),
                              Responsive.width(context, 0.06),
                              Responsive.height(context, 0.035),
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.5),
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(32),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'EXAMPLE DISHES YOU CAN DISCOVER',
                                  style: TextStyle(
                                    fontSize: Responsive.scale(context, 10),
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.2,
                                    color: AppColors.textSecondary.withOpacity(
                                      0.6,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                SizedBox(
                                  height: Responsive.scale(
                                    context,
                                    140,
                                  ).clamp(120.0, 180.0).toDouble(),
                                  child: viewModel.loadingSuggestion
                                      ? const Center(
                                          child: CircularProgressIndicator(
                                            color: AppColors.primary,
                                            strokeWidth: 2,
                                          ),
                                        )
                                      : ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          physics:
                                              const BouncingScrollPhysics(),
                                          itemCount:
                                              viewModel.suggestions.length,
                                          itemBuilder: (context, index) {
                                            final item =
                                                viewModel.suggestions[index];
                                            return _buildDishItem(
                                              context,
                                              item.name ?? 'Unknown',
                                              item.imageUrl ?? '',
                                              onTap: () {
                                                viewModel.navigateToDetail(
                                                  context,
                                                  viewModel
                                                      .suggestions[index]
                                                      .id!,
                                                );
                                              },
                                            );
                                          },
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
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildDishItem(
    BuildContext context,
    String name,
    String imageUrl, {
    required VoidCallback onTap,
  }) {
    final itemWidth = Responsive.scale(
      context,
      120,
    ).clamp(100.0, 150.0).toDouble();
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: itemWidth,
        margin: const EdgeInsets.only(right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  width: itemWidth,
                  errorBuilder: (context, error, stackTrace) {
                    Console.log('❌ Image failed to load: $name');
                    Console.log('❌ URL: $imageUrl');
                    Console.log('❌ Error: $error');
                    return Container(
                      color: Colors.grey[200],
                      child: const Icon(
                        Icons.broken_image,
                        size: 40,
                        color: Colors.grey,
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              name,
              style: TextStyle(
                fontSize: Responsive.scale(context, 14),
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
