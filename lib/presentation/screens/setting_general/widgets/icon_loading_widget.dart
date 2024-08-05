import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:todo/application/constants/app_colors.dart';
import 'package:todo/gen/assets.gen.dart';

class IconLoadingWidget extends StatefulWidget {
  final String pathIcon;
  final bool isChosen;

  const IconLoadingWidget(
      {super.key, required this.pathIcon, required this.isChosen});

  @override
  State<IconLoadingWidget> createState() => _IconLoadingWidgetState();
}

class _IconLoadingWidgetState extends State<IconLoadingWidget> {
  @override
  Widget build(BuildContext context) {
    final currentTheme = AdaptiveTheme.of(context).theme;

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

                border: Border.all(color: AppColors.grey.withOpacity(0.5),width: 1.r),
                  borderRadius: BorderRadius.circular(8.r)),
              child: Lottie.asset(widget.pathIcon),
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
                    color: currentTheme.primaryColor,
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
    ]);
  }
}
