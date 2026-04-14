import 'package:ai_menu_flutter/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/app_service.dart';

class OnboardScreen extends StatelessWidget {
  const OnboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    // specific colors from HTML template
    const primaryColor = Color(0xFFFF8E42);
    final backgroundColor = isDarkMode
        ? const Color(0xFF23170F)
        : const Color(0xFFF8F7F5);
    final textColor = isDarkMode
        ? Colors.white
        : const Color(0xFF0F172A); // Slate 900
    final subTextColor = isDarkMode
        ? const Color(0xFF94A3B8)
        : const Color(0xFF475569); // Slate 400/600

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'MenuAI',
                style: TextStyle(
                  color: textColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Hero Image Section
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: AspectRatio(
                        aspectRatio: 4 / 3,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: primaryColor.withOpacity(0.1),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                            image: const DecorationImage(
                              image: NetworkImage(
                                "https://lh3.googleusercontent.com/aida-public/AB6AXuAC-DfPPppV7B7-ERwbgXzORtM8dgFuq5SCFHJY0RutGM7i73TSiVJflhryVYMxjXgsfHBlofBjXYraNaAVgDOWsirrwwChEqLK3XPechNyy0IJSJU64_QIIaYAAHh_8YxvgvLgDTVr3mQc67oPs9oxC335Tj-Y-eoVKUMl3NYt-szIRV3ZFtHeElWpweO9Z1jM0NnSBZoedzUzKj3_jOpnQWSpxMRpPVSDliITq1M6USVzr2ceVZ4qiEhks7C41tzbq3P5H0UD5C4",
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Content Section
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        children: [
                          const SizedBox(height: 32),
                          Text(
                            'Cook with what you already have',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: textColor,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              height: 1.1,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Take a photo of your ingredients and MenuAI will suggest dishes you can cook.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: subTextColor,
                              fontSize: 16,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 32),

                          // Steps
                          _buildStep(
                            context,
                            icon: Icons.photo_camera_outlined,
                            title: 'Take a photo of ingredients',
                            description:
                                'Snap what\'s in your fridge or pantry',
                            showLine: true,
                            primaryColor: primaryColor,
                            textColor: textColor,
                            subTextColor: subTextColor,
                          ),
                          _buildStep(
                            context,
                            icon: Icons.auto_awesome_outlined,
                            title: 'AI detects the ingredients',
                            description:
                                'Our smart AI identifies everything for you',
                            showLine: true,
                            primaryColor: primaryColor,
                            textColor: textColor,
                            subTextColor: subTextColor,
                          ),
                          _buildStep(
                            context,
                            icon: Icons.restaurant_menu_outlined,
                            title: 'Get recommended recipes',
                            description:
                                'Choose from delicious custom meal ideas',
                            showLine: false,
                            primaryColor: primaryColor,
                            textColor: textColor,
                            subTextColor: subTextColor,
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Action Button
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    final appService = context.read<AppService>();
                    appService.onboarded = true;
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    elevation: 8,
                    shadowColor: primaryColor.withOpacity(0.4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'Start Cooking',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildStep(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
    required bool showLine,
    required Color primaryColor,
    required Color textColor,
    required Color subTextColor,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: primaryColor, size: 24),
            ),
            if (showLine)
              Container(
                width: 2,
                height: 40,
                color: primaryColor.withOpacity(0.2),
              ),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Text(
                title,
                style: TextStyle(
                  color: textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(color: subTextColor, fontSize: 14),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ],
    );
  }
}
