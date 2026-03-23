import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/colors.dart';

class AppNavActionButton extends StatelessWidget {
  const AppNavActionButton({
    super.key,
    required this.icon,
    this.onTap,
    this.color,
    this.showShadow = true,
    this.showBorder = true,
  });

  final IconData icon;
  final VoidCallback? onTap;
  final Color? color;
  final bool showShadow;
  final bool showBorder;

  static const double size = 42;
  static const double horizontalPadding = 16;
  static const double verticalPadding = 8;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: verticalPadding),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.94),
            shape: BoxShape.circle,
            border: showBorder ? Border.all(
              color: AppColors.textSecondary.withValues(alpha: 0.12),
            ) : null,
            boxShadow: showShadow ? [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ] : null,
          ),
          child: Icon(icon, color: color ?? AppColors.accentBrown),
        ),
      ),
    );
  }
}

class AppHeaderActionsWrapper extends StatelessWidget {
  const AppHeaderActionsWrapper({
    super.key,
    this.leading,
    this.trailing,
    this.title,
    this.titleColor,
  });

  final Widget? leading;
  final Widget? trailing;
  final String? title;
  final Color? titleColor;

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    return Padding(
      padding: EdgeInsets.only(
        top: topPadding,
        left: AppNavActionButton.horizontalPadding,
        right: AppNavActionButton.horizontalPadding,
      ),
      child: SizedBox(
        height: AppNavActionButton.size + AppNavActionButton.verticalPadding * 2,
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (title != null)
              Text(
                title!,
                style: GoogleFonts.inter(
                  color: titleColor ?? AppColors.accentBrown,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                leading ?? const SizedBox(width: AppNavActionButton.size),
                if (trailing != null) trailing!,
              ],
            ),
          ],
        ),
      ),
    );
  }
}
