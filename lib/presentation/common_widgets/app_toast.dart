import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../application/constants/app_colors.dart';
import 'app_text.dart';

class AppToast {
  static void showToastError(BuildContext context, {required String title}) {
    _showToast(context, title, AppColors.red, Icons.error_outline);
  }

  static void showToastSuccess(BuildContext context, {required String title}) {
    _showToast(context, title, Colors.green, Icons.check_circle_outline);
  }

  static void _showToast(BuildContext context, String title, Color color, IconData icon) {
    final overlay = Overlay.of(context);
    OverlayEntry? entry;
    entry = OverlayEntry(
      builder: (context) => Positioned(
        top: 10.h,
        left: 0,
        right: 0,
        child: Material(
          color: Colors.transparent,
          child: TweenAnimationBuilder<double>(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
            tween: Tween(begin: -100.0, end: 50.h),
            builder: (context, value, child) {
              return Transform.translate(
                offset: Offset(0, value),
                child: child,
              );
            },
            child: Container(
              width: 1.sw,
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: AppColors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: const Offset(0.2, 0.5),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    icon,
                    color: color,
                    size: 25.r,
                  ),
                  SizedBox(width: 16.w),
                  AppText(title, fontSize: 14.sp, color: color)
                ],
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(entry);

    Future.delayed(const Duration(milliseconds: 2000), () {
      if (entry != null) {
        entry.remove();
      }
    });
  }
}