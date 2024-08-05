import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/application/constants/app_colors.dart';
import 'package:todo/application/constants/app_text_style.dart';
import 'package:todo/gen/assets.gen.dart';

class ItemFunction extends StatelessWidget {
  final Widget actionIcon;
  final String titleAction;
  final Color color;
  final VoidCallback? action;
  final bool isLeading;

  const ItemFunction(
      {super.key,
      required this.actionIcon,
      required this.titleAction,
      this.action,
      this.isLeading = true,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {action?.call()},
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                actionIcon,
                SizedBox(
                  width: 18.w,
                ),
                Text(
                  titleAction,
                  style: AppTextStyle.textSm
                      .copyWith(color: color, fontWeight: FontWeight.w400),
                ),
              ],
            ),
            isLeading
                ? Assets.icons.angleSmallRight.svg(
                    colorFilter:
                        const ColorFilter.mode(AppColors.grayD1, BlendMode.srcIn))
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}
