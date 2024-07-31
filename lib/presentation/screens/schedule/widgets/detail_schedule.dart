import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo/application/constants/app_colors.dart';
import 'package:todo/application/constants/app_text_style.dart';
import 'package:todo/domain/models/response/schedule/event_response.dart';
import 'package:todo/gen/assets.gen.dart';
import 'package:todo/presentation/common_widgets/app_bottom_sheet.dart';
import 'package:todo/presentation/screens/create_edit_schedule/create_edit_schedule_screen.dart';
import 'package:todo/presentation/screens/schedule/widgets/confirm_widget.dart';

class DetailSchedule extends StatelessWidget {
  final EventResponse event;

  const DetailSchedule({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.r), topRight: Radius.circular(16.r))),
      padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 12.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${tr("time")} ${event.startTime} - ${event.endTime}',
                style:
                AppTextStyle.textBase.copyWith(fontWeight: FontWeight.w500),
              ),
              InkWell(
                onTap: () {

                },
                child: Container(
                  padding: EdgeInsets.all(8.r),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: AppColors.grey.withOpacity(0.2)),
                  child: SvgPicture.asset(
                    Assets.icons.iconCheckbox.path,
                    width: 20.r,
                    height: 20.r,
                    colorFilter:  ColorFilter.mode( event.status==true ?
                        AppColors.green : AppColors.grey, BlendMode.srcIn),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  AppBottomSheet.showBottomSheet(context,
                      child: EditSchedule(
                        event: event,
                      ));
                },
                child: Container(
                  padding: EdgeInsets.all(8.r),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: AppColors.grey.withOpacity(0.2)),
                  child: SvgPicture.asset(
                    Assets.icons.iconEdit.path,
                    width: 20.r,
                    height: 20.r,
                    colorFilter: const ColorFilter.mode(
                        AppColors.yellow, BlendMode.srcIn),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) => ConfirmWidget(
                            onConfirm: () {},
                          ));
                },
                child: Container(
                  padding: EdgeInsets.all(8.r),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: AppColors.grey.withOpacity(0.2)),
                  child: SvgPicture.asset(
                    Assets.icons.iconDelete.path,
                    width: 20.r,
                    height: 20.r,
                    colorFilter:
                        const ColorFilter.mode(AppColors.red, BlendMode.srcIn),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          Text(
            event.title,
            style: AppTextStyle.textBase
                .copyWith(fontWeight: FontWeight.bold, color: Colors.blue),
          ),
          SizedBox(
            height: 12.h,
          ),
          Text(event.content ?? "",
              style: AppTextStyle.textSm.copyWith(
                  fontWeight: FontWeight.w400, color: AppColors.grey1))
        ],
      ),
    );
  }
}
