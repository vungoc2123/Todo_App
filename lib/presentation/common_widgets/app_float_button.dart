import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/application/constants/app_colors.dart';
import 'package:todo/gen/assets.gen.dart';

class AppFloatButton extends StatelessWidget {
  final VoidCallback onPress;
  const AppFloatButton({super.key, required this.onPress});

  @override
  Widget build(BuildContext context) {
    final currentTheme = AdaptiveTheme.of(context).theme;

    return FloatingActionButton(
      onPressed: onPress,
      shape: const CircleBorder(),
      backgroundColor: currentTheme.primaryColor,
      child: Assets.icons.plus.svg(
          width: 20.r,
          height: 20.r,
          colorFilter:
          const ColorFilter.mode(AppColors.white, BlendMode.srcIn)),
    );
  }
}
