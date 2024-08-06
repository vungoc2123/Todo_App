import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:todo/application/constants/app_colors.dart';
import 'package:todo/application/constants/app_text_style.dart';
import 'package:todo/application/extensions/string_extension.dart';

class ItemTaskGroupModel {
  final String id;
  final String icon;
  final String color;
  final String title;
  final String content;
  final double percent;
  final int quantity;
  final String uid;
  final String createAt;

  ItemTaskGroupModel(
      {required this.id,
      required this.icon,
      required this.color,
      required this.title,
      required this.content,
      required this.percent,
      required this.uid,
      required this.createAt,
      required this.quantity});
}

class ItemTaskGroup extends StatelessWidget {
  const ItemTaskGroup({super.key, required this.itemTaskGroupModel});

  final ItemTaskGroupModel itemTaskGroupModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
          color: AppColors.white, borderRadius: BorderRadius.circular(16.r)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              width: 50.r,
              height: 50.r,
              padding: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color:
                      itemTaskGroupModel.color.hexToColor().withOpacity(0.3)),
              child: SvgPicture.asset(itemTaskGroupModel.icon,
                  colorFilter: ColorFilter.mode(
                      itemTaskGroupModel.color.hexToColor(), BlendMode.srcIn))),
          SizedBox(
            width: 16.h,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  itemTaskGroupModel.title,
                  style: AppTextStyle.textBase
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                Text(
                  "${itemTaskGroupModel.quantity} Tasks",
                  style: AppTextStyle.textSm,
                )
              ],
            ),
          ),
          CircularPercentIndicator(
            radius: 30.r,
            lineWidth: 5.0,
            percent: itemTaskGroupModel.percent,
            center: Text("${itemTaskGroupModel.content}%"),
            progressColor: itemTaskGroupModel.color.hexToColor(),
            backgroundColor:
                itemTaskGroupModel.color.hexToColor().withOpacity(0.3),
          )
        ],
      ),
    );
  }
}
