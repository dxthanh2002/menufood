import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/colors.dart';

class AppNavActionButton extends StatelessWidget {
  const AppNavActionButton({
    super.key,
    required this.icon,
    this.onTap,
    this.color,
  });

  final IconData icon;
  final VoidCallback? onTap;
  final Color? color;

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
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppNavActionButton.horizontalPadding,
        ),
        child: Container(
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
      ),
    );
  }
}
