import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../application/constants/app_colors.dart';
import '../../../../application/constants/app_text_style.dart';

class ButtonLoginWidget extends StatelessWidget {
  final String nameButton;
  final Widget icon;
  final VoidCallback? action;

  const ButtonLoginWidget({
    super.key,
    required this.nameButton,
    this.action,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(4.r),
      onTap: action,
      splashColor: AppColors.red
          .withOpacity(0.3),
      highlightColor: AppColors.grey1.withOpacity(0.1),
      child: Ink(
          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
        decoration: BoxDecoration(
          color: AppColors.gray,
          borderRadius: BorderRadius.circular(4.r),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: icon,
            ),
            Expanded(
              flex: 3,
              child: Text(
                nameButton,
                style:
                    AppTextStyle.textSm.copyWith(color: AppColors.textPrimary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
