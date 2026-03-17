import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../utils/responsive_util.dart';

class UserSettingScreen extends StatelessWidget {
  const UserSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isTablet = Responsive.isTablet(context);
    final horizontalPadding = isTablet ? Responsive.width(context, 0.1) : 16.0;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, 
            color: AppColors.textPrimary, 
            size: Responsive.scale(context, 24).clamp(20.0, 28.0)
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Settings',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
            fontSize: Responsive.scale(context, 20).clamp(18.0, 24.0),
          ),
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionHeader(context, 'Account'),
                _buildSectionContainer([
                  _buildSettingItem(
                    context,
                    icon: Icons.notifications_none_rounded,
                    title: 'Notifications',
                    onTap: () {},
                  ),
                  _buildSettingItem(
                    context,
                    icon: Icons.lock_outline_rounded,
                    title: 'Privacy',
                    onTap: () {},
                  ),
                  _buildSettingItem(
                    context,
                    icon: Icons.security_rounded,
                    title: 'Security',
                    showBorder: false,
                    onTap: () {},
                  ),
                ]),
                const SizedBox(height: 24),
                _buildSectionHeader(context, 'Preferences'),
                _buildSectionContainer([
                  _buildSettingItem(
                    context,
                    icon: Icons.straighten_rounded,
                    title: 'Measurement Units',
                    subtitle: 'Metric (cm, kg, ml)',
                    onTap: () {},
                  ),
                  _buildSettingItem(
                    context,
                    icon: Icons.restaurant_rounded,
                    title: 'Dietary Preferences',
                    subtitle: 'Vegetarian, Low-Carb',
                    onTap: () {},
                  ),
                  _buildSettingItem(
                    context,
                    icon: Icons.language_rounded,
                    title: 'Language',
                    subtitle: 'English (US)',
                    showBorder: false,
                    onTap: () {},
                  ),
                ]),
                const SizedBox(height: 24),
                _buildSectionHeader(context, 'Support'),
                _buildSectionContainer([
                  _buildSettingItem(
                    context,
                    icon: Icons.help_outline_rounded,
                    title: 'Help Center',
                    onTap: () {},
                  ),
                  _buildSettingItem(
                    context,
                    icon: Icons.chat_bubble_outline_rounded,
                    title: 'Feedback',
                    onTap: () {},
                  ),
                  _buildSettingItem(
                    context,
                    icon: Icons.info_outline_rounded,
                    title: 'About MenuAI',
                    showBorder: false,
                    onTap: () {},
                  ),
                ]),
                const SizedBox(height: 32),
                Center(
                  child: TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.logout_rounded, color: Colors.redAccent),
                    label: Text(
                      'Log Out',
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: Responsive.scale(context, 16).clamp(14.0, 18.0),
                      ),
                    ),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 12),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          color: AppColors.textSecondary.withOpacity(0.6),
          fontSize: Responsive.scale(context, 11).clamp(10.0, 13.0),
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildSectionContainer(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black.withOpacity(0.04)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 15,
            offset: Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(children: children),
    );
  }

  Widget _buildSettingItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
    bool showBorder = true,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          border: showBorder
              ? Border(
                  bottom: BorderSide(
                    color: Colors.black.withOpacity(0.04),
                    width: 1,
                  ),
                )
              : null,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: AppColors.primary,
              size: Responsive.scale(context, 24).clamp(20.0, 28.0),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                      fontSize: Responsive.scale(context, 16).clamp(14.0, 18.0),
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: Responsive.scale(context, 12).clamp(10.0, 14.0),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: AppColors.navInactive.withOpacity(0.4),
              size: Responsive.scale(context, 20).clamp(18.0, 24.0),
            ),
          ],
        ),
      ),
    );
  }
}
