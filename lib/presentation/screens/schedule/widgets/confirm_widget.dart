import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo/application/constants/app_colors.dart';
import 'package:todo/application/constants/app_text_style.dart';
import 'package:todo/gen/assets.gen.dart';
import 'package:todo/presentation/common_widgets/app_button.dart';

class ConfirmWidget extends StatelessWidget {
  final VoidCallback onConfirm;
  const ConfirmWidget({super.key,required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 200.h,
        margin: EdgeInsets.symmetric(vertical: 20,horizontal: 50.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r), color: AppColors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              padding: EdgeInsets.all(8.r),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: AppColors.grey.withOpacity(0.2)),
              child: SvgPicture.asset(
                Assets.icons.iconDelete.path,
                width: 30.r,
                height: 30.r,
                colorFilter:
                const ColorFilter.mode(AppColors.red, BlendMode.srcIn),
              ),
            ),
            Text(tr("confirmDelete"),style: AppTextStyle.textBase,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(width: 12.w,),
                Flexible(
                    flex: 1,
                    child: AppButton(
                      title: tr("yes"),
                      color: AppColors.yellow,
                      radius: 12.r,
                    )),
                SizedBox(width: 20.w,),
                Flexible(
                  flex: 1,
                  child: AppButton(
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                    title: tr("cancel"),
                    color: Colors.lightBlueAccent,
                    radius: 12.r,
                  ),
                ),
                SizedBox(width: 12.w,),
              ],
            )
          ],
        ),
      ),
    );
  }
}
