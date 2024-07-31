import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo/application/constants/app_colors.dart';
import 'package:todo/application/constants/app_text_style.dart';
import 'package:todo/application/extensions/date_time_extension.dart';
import 'package:todo/gen/assets.gen.dart';

class SelectTime extends StatelessWidget {
  final TimeOfDay time;
  const SelectTime({super.key,required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(12.r),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.w),
            border: Border.all(color: AppColors.stroke)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              time.toFormattedString(),
              style: AppTextStyle.textBase
                  .copyWith(fontWeight: FontWeight.w400, color: AppColors.grey),
            ),
            SizedBox(
              width: 12.w,
            ),
            SvgPicture.asset(Assets.icons.iconClockThree.path)
          ],
        ));
  }
}
