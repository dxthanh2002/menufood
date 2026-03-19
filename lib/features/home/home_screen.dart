import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
                                    onPressed: () {},
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
                                  child: ListView(
                                    scrollDirection: Axis.horizontal,
                                    physics: const BouncingScrollPhysics(),
                                    children: [
                                      _buildDishItem(
                                        context,
                                        'Fresh Pasta',
                                        'https://lh3.googleusercontent.com/aida-public/AB6AXuCfQbFFoq5WfZjqa8YjW5VBjE-lVRMIcNmbb9KGiiFVd_U8zlko9zYc9ZBoA0QtRCZgvZRW5LhHlaagCwgw_be2t5miG65T3jYcr2_G41Pu-FGx1RzBfzj-R6Ejj6Fq968Qyl1ihLrwWxjrjzd2-tRUX31RryQt21Naa0lgHiXyN9XHZjnc_3FSDbJ1G_rCM1FnbNWNuAqlV-MKaZqT7B-oGws95-yuMICtTwK85WsA6lX7JzVuDCHGmabab8VvzRUZqBlOPBZfBvI',
                                      ),
                                      _buildDishItem(
                                        context,
                                        'Herb Omelet',
                                        'https://lh3.googleusercontent.com/aida-public/AB6AXuDeneYEGfFziZ8XdM6vRgpwwD5qZJMn9mv29E8_6tsCHz2hn5_M6xnBdCpu0CkYp-bJa2SsubMAk2xw-PVqhkXo6kVu7pEhyRHF-rJxtJKes7ue2e5q5mFVQa2QaejFpwrV46OF7ujGhXj9SmmhI17frq9CjsYxz_hFTbHXB6rOo2-nZnIna_Gn4WaLlcZ1k1L9ShPtMJuGSfegGpZdx32p7SWUwCIXboAo8sbwR_dKt-w_mj2kJLbwH25mOTbwW_of38lFp7jaDfI',
                                      ),
                                      _buildDishItem(
                                        context,
                                        'Garden Salad',
                                        'https://lh3.googleusercontent.com/aida-public/AB6AXuBI_4EG6xH4pxpMwGxh22BI0ZwSojP4md47M_8DqWkfKJWgvJuUmlx2GUpOth39laqNLj6A4kYfnnPFODtLH3nlEnpxGvUC8f074T3Q8D7u0PA3myfL8vWMkw5KviNDUyQS2qVpgNrCCtXZqm8xAvTLeR1Kf7CsNwm6D1fhtfuQzcmu127D94m8cdr5KQaB3241y-Vha6xXu4biHwmKvVkB3uEvNyDGWxCfZ_enehBhcKoo6ScPDCdDSDVLeSYEVtg3xsoZf9pkDeU',
                                      ),
                                      _buildDishItem(
                                        context,
                                        'Quinoa Bowl',
                                        'https://lh3.googleusercontent.com/aida-public/AB6AXuCVBoQiHsioegc1uRzNeUdpFQILKYPmji28m76VH_t5thYUW2OumRZz6FsUgIk--Pi-N7VIlrcufQsBPfQCX1xrqPKReH-cZOy-F2pOyljDEzPVf0lXzn3e1UPBeQpRlgTzizQy-EFlw8OQ4sQGBLKokNEtDR0ocRCzi0YmXsk1mQ9ULwEvY5z5CQG8TPGxmBpRptGrGO3JM0Or8RPvtZhoM48k3CzFmJyrWLX3de8llLBL_r0ZmsoMCDD3TS5IjXreRU19-jgDzkw',
                                      ),
                                    ],
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

  Widget _buildDishItem(BuildContext context, String name, String imageUrl) {
    final itemWidth = Responsive.scale(
      context,
      120,
    ).clamp(100.0, 150.0).toDouble();
    return Container(
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
    );
  }
}
