import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo/application/constants/app_colors.dart';
import 'package:todo/application/constants/app_text_style.dart';
import 'package:todo/application/constants/app_theme.dart';
import 'package:todo/gen/assets.gen.dart';

class ThemeWidget extends StatefulWidget {
  final AppThemeModel appTheme;
  final bool isChosen;

  const ThemeWidget(
      {super.key, required this.appTheme, required this.isChosen});

  @override
  State<ThemeWidget> createState() => _ThemeWidgetState();
}

class _ThemeWidgetState extends State<ThemeWidget> {
  @override
  Widget build(BuildContext context) {
    final size = (1.sw - 94.r) / 4;
    return Column(children: [
      SizedBox(
        width: size,
        height: size,
        child: Stack(children: [
          Positioned(
            bottom: 0,
            child: Container(
              width: size - 4.r,
              height: size - 4.r,
              decoration: BoxDecoration(
                  color: widget.appTheme.themeData.primaryColor,
                  borderRadius: BorderRadius.circular(8.r)),
            ),
          ),
          AnimatedOpacity(
            opacity: widget.isChosen ? 1.0 : 0,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInSine,
            child: Align(
              alignment: Alignment.topRight,
              child: Container(
                padding: EdgeInsets.all(3.r),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    color: widget.appTheme.themeData.primaryColor,
                    border: Border.all(color: AppColors.white, width: 2.r)),
                child: SvgPicture.asset(Assets.icons.iconTick.path,
                    width: 12.r,
                    height: 12.r,
                    colorFilter: const ColorFilter.mode(
                        AppColors.white, BlendMode.srcIn)),
              ),
            ),
          ),
        ]),
      ),
      SizedBox(
        height: 4.h,
      ),
      Text(
        widget.appTheme.title,
        style: AppTextStyle.textXs
            .copyWith(color: AppColors.grey, fontWeight: FontWeight.w600),
      )
    ]);
  }
}
