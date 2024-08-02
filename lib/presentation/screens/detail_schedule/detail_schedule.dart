import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo/application/constants/app_colors.dart';
import 'package:todo/application/constants/app_text_style.dart';
import 'package:todo/application/enums/load_status.dart';
import 'package:todo/domain/models/response/schedule/event_response.dart';
import 'package:todo/gen/assets.gen.dart';
import 'package:todo/presentation/common_widgets/app_loading.dart';
import 'package:todo/presentation/common_widgets/app_toast.dart';
import 'package:todo/presentation/routes/route_name.dart';
import 'package:todo/presentation/screens/detail_schedule/detail_schedule_cubit.dart';
import 'package:todo/presentation/screens/detail_schedule/detail_schedule_state.dart';
import 'package:todo/presentation/screens/schedule/widgets/confirm_widget.dart';

class DetailSchedule extends StatefulWidget {
  final EventResponse event;

  const DetailSchedule({super.key, required this.event});

  @override
  State<DetailSchedule> createState() => _DetailScheduleState();
}

class _DetailScheduleState extends State<DetailSchedule> {
  late DetailScheduleCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of<DetailScheduleCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DetailScheduleCubit, DetailScheduleState>(
      listener: (context, state) {
        if (state.loadStatus == LoadStatus.success) {
          Navigator.of(context).pop();
          Navigator.of(context).pop(true);
          // Navigator.of(context).pop();
          AppToast.showToastSuccess(context, title: tr('processSuccess'));
        }
        if (state.loadStatus == LoadStatus.failure) {
          Navigator.of(context).pop();
          AppToast.showToastError(context, title: tr("processFailed"));
        }
        if (state.loadStatus == LoadStatus.loading) {
          showDialog(
              context: context,
              builder: (context) => const AppLoading(),
              barrierDismissible: false);
        }
      },
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r))),
        padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${tr("time")} ${widget.event.startTime} - ${widget.event.endTime}',
                  style: AppTextStyle.textBase
                      .copyWith(fontWeight: FontWeight.w500),
                ),
                InkWell(
                  onTap: () {
                    _cubit.changeStatusEvent(widget.event);
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
                      colorFilter: ColorFilter.mode(
                          widget.event.status == true
                              ? AppColors.green
                              : AppColors.grey,
                          BlendMode.srcIn),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                        RouteName.createEditSchedule,
                        arguments: widget.event);
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
                    _cubit.deleteEvent(widget.event.idEvent);
                    // showDialog(
                    //     context: context,
                    //     builder: (context) => ConfirmWidget(
                    //           onConfirm: () {
                    //             _cubit.deleteEvent(widget.event.idEvent);
                    //           },
                    //         ));
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
                      colorFilter: const ColorFilter.mode(
                          AppColors.red, BlendMode.srcIn),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              widget.event.title,
              style: AppTextStyle.textBase
                  .copyWith(fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            SizedBox(
              height: 12.h,
            ),
            Text(widget.event.content ?? "",
                style: AppTextStyle.textSm.copyWith(
                    fontWeight: FontWeight.w400, color: AppColors.grey1))
          ],
        ),
      ),
    );
  }
}
