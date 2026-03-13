import 'package:flutter/material.dart';
import '../common_types.dart';

class SecondaryAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const SecondaryAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.appBar,
      foregroundColor: AppColors.textPrimary,
      title: Text(
        title,
        style: const TextStyle(
          fontSize: AppSizes.appBarFontSize,
          color: AppColors.accent,
          fontFamily: "Audiowide",
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}