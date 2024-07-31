import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/application/constants/app_colors.dart';
import 'package:todo/application/utils/app_utils.dart';
import 'package:todo/application/constants/app_text_style.dart';


class AppButton extends StatelessWidget {
  final String title;
  final Color color;
  final TextStyle? textStyle;
  final Widget? icon;
  final double? height;
  final bool isEnable;
  final double? radius;
  final VoidCallback? onPressed;
  final Color? borderColor;

  const AppButton({super.key,
    required this.title,
    required this.color,
    this.textStyle,
    this.icon,
    this.height,
    this.isEnable = true,
    this.radius,
    this.onPressed,
    this.borderColor});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isEnable ? 1 : 0.6,
      child: GestureDetector(
        onTap: () {
          AppUtils.dismissKeyboard();
          if (!isEnable) return;
          onPressed?.call();
        },
        child: Container(
          width: double.infinity,
          height: height?? 50.h,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(radius ?? 100.w),
            border: Border.all(color: borderColor ?? color),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (icon != null) ...[
                icon!,
                SizedBox(width: 4.w),
              ],
              Text(title, style: textStyle ?? AppTextStyle.textSm.copyWith(
                  fontWeight: FontWeight.w400, color: AppColors.textPrimary),)
            ],
          ),
        ),
      ),
    );
  }
}
