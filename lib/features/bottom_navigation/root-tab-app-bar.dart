import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../utils/responsive_util.dart';

class RootTabAppBar extends StatelessWidget implements PreferredSizeWidget {
  const RootTabAppBar({
    super.key,
    required this.title,
    this.leading,
    this.trailing,
  });

  final String title;
  final Widget? leading;
  final Widget? trailing;

  static const double _toolbarHeight = 64;
  static const double _actionSize = 44;
  static const EdgeInsets _horizontalPadding = EdgeInsets.symmetric(
    horizontal: 16,
  );

  @override
  Size get preferredSize => const Size.fromHeight(_toolbarHeight);

  @override
  Widget build(BuildContext context) {
    final titleSize = Responsive.scale(context, 20).clamp(18.0, 22.0);

    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      toolbarHeight: _toolbarHeight,
      centerTitle: true,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      leadingWidth: 76,
      leading: Padding(
        padding: _horizontalPadding.copyWith(right: 0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: leading ?? const _HeaderPlaceholder(),
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: AppColors.accentBrown,
          fontWeight: FontWeight.w700,
          fontSize: titleSize,
          letterSpacing: -0.3,
        ),
      ),
      actions: [
        Padding(
          padding: _horizontalPadding.copyWith(left: 0),
          child: Align(
            alignment: Alignment.centerRight,
            child: trailing ?? const _HeaderPlaceholder(),
          ),
        ),
      ],
    );
  }

  static Widget buildActionButton({
    required Widget icon,
    required VoidCallback? onPressed,
    Color backgroundColor = AppColors.softCream,
  }) {
    return SizedBox(
      width: _actionSize,
      height: _actionSize,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
        ),
        child: IconButton(onPressed: onPressed, icon: icon),
      ),
    );
  }
}

class _HeaderPlaceholder extends StatelessWidget {
  const _HeaderPlaceholder();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(width: RootTabAppBar._actionSize);
  }
}
