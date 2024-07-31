import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo/application/constants/app_text_style.dart';
import 'package:todo/domain/models/response/schedule/event_response.dart';
import 'package:todo/gen/assets.gen.dart';

class ScheduleWidget extends StatelessWidget {
  final EventResponse event;

  const ScheduleWidget({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(width: 0.5, color: Colors.blue),
          color: event.status == true ? Colors.grey.withOpacity(0.3) : Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                Assets.icons.iconCalendar.path,
                width: 16.r,
                height: 16.r,
                colorFilter:
                    const ColorFilter.mode(Colors.black54, BlendMode.srcIn),
              ),
              SizedBox(
                width: 12.w,
              ),
              Text(
                '${event.startTime} - ${event.endTime}',
                style: AppTextStyle.textSm.copyWith(color: Colors.black54),
              )
            ],
          ),
          SizedBox(
            height: 4.h,
          ),
          Text(
            event.title,
            style: AppTextStyle.textSm.copyWith(fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 4.h,
          ),
          Text(
            event.content ?? "" '\n',
            style: AppTextStyle.textSm.copyWith(
                fontWeight: FontWeight.w400,
                color: Colors.black.withOpacity(0.6)),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
