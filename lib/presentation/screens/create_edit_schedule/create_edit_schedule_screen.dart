import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo/application/constants/app_colors.dart';
import 'package:todo/application/constants/app_text_style.dart';
import 'package:todo/application/enums/load_status.dart';
import 'package:todo/application/extensions/date_time_extension.dart';
import 'package:todo/domain/models/response/schedule/event_response.dart';
import 'package:todo/gen/assets.gen.dart';
import 'package:todo/presentation/common_widgets/app_button.dart';
import 'package:todo/presentation/common_widgets/app_label_text_field.dart';
import 'package:todo/presentation/common_widgets/app_loading.dart';
import 'package:todo/presentation/common_widgets/app_toast.dart';
import 'package:todo/presentation/screens/create_edit_schedule/create_edit_schedule_cubit.dart';
import 'package:todo/presentation/screens/create_edit_schedule/create_edit_schedule_state.dart';
import 'package:todo/presentation/screens/schedule/widgets/select_time.dart';

class EditSchedule extends StatefulWidget {
  final EventResponse? event;

  const EditSchedule({super.key, this.event});

  @override
  State<EditSchedule> createState() => _EditScheduleState();
}

class _EditScheduleState extends State<EditSchedule> {
  late CreateEditScheduleCubit _cubit;
  late ValueNotifier<DateTime> date;

  late ValueNotifier<TimeOfDay> timeStart;
  late ValueNotifier<TimeOfDay> timeEnd;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of<CreateEditScheduleCubit>(context);
    date = ValueNotifier<DateTime>(
        widget.event?.date.toDateTime() ?? DateTime.now());
    timeStart =
        ValueNotifier(widget.event?.startTime.toTimeOfDay() ?? TimeOfDay.now());
    timeEnd =
        ValueNotifier(widget.event?.endTime.toTimeOfDay() ?? TimeOfDay.now());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateEditScheduleCubit, CreateEditScheduleState>(
      listener: (context, state) {
        if (state.loadStatus == LoadStatus.loading) {
          showDialog(
              context: context,
              builder: (context) => const AppLoading(),
              barrierDismissible: false);
        }
        if (state.loadStatus == LoadStatus.success) {
          Navigator.of(context).pop();
          AppToast.showToastSuccess(context, title: "Thêm mới lịch thành công");
        }
        if (state.loadStatus == LoadStatus.failure) {
          Navigator.of(context).pop();
          AppToast.showToastError(context, title: "Thêm mới lịch thất bại");
        }
      },
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r))),
        padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 8.w),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(),
                  Text(
                    widget.event != null
                        ? tr("editSchedule")
                        : tr("addNewSchedule"),
                    style: AppTextStyle.textBase
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: SvgPicture.asset(
                      Assets.icons.iconClose.path,
                      width: 16.r,
                      height: 16.r,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 12.h,
            ),
            CustomLabelTextField(
                defaultValue: widget.event?.title ?? "", hintText: tr("title")),
            CustomLabelTextField(
              defaultValue: widget.event?.content ?? "",
              hintText: tr("note"),
              maxLine: 4,
            ),
            SizedBox(
              height: 8.h,
            ),
            InkWell(
              onTap: () async {
                date.value = (await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2024),
                        lastDate: DateTime(2050))) ??
                    date.value;
              },
              child: ValueListenableBuilder(
                valueListenable: date,
                builder: (context, value, __) {
                  return Container(
                    padding: EdgeInsets.all(12.r),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.w),
                        border: Border.all(color: AppColors.stroke)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          value.toFormattedString(),
                          style: AppTextStyle.textBase.copyWith(
                              fontWeight: FontWeight.w400,
                              color: AppColors.grey),
                        ),
                        SizedBox(
                          width: 12.w,
                        ),
                        SvgPicture.asset(
                          Assets.icons.iconCalendar.path,
                          colorFilter: const ColorFilter.mode(
                              AppColors.grey, BlendMode.srcIn),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            Row(
              children: [
                Text(
                  tr("startTime"),
                  style: AppTextStyle.textBase
                      .copyWith(color: AppColors.textPrimary),
                ),
                SizedBox(
                  width: 16.w,
                ),
                InkWell(
                  onTap: () async {
                    timeStart.value = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                          initialEntryMode: TimePickerEntryMode.dial,
                        ) ??
                        timeStart.value;
                  },
                  child: ValueListenableBuilder(
                    valueListenable: timeStart,
                    builder: (context, value, __) => SelectTime(time: value),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 12.h,
            ),
            Row(
              children: [
                Text(
                  tr("endTime"),
                  style: AppTextStyle.textBase
                      .copyWith(color: AppColors.textPrimary),
                ),
                SizedBox(
                  width: 16.w,
                ),
                InkWell(
                  onTap: () async {
                    timeEnd.value = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                          initialEntryMode: TimePickerEntryMode.dial,
                        ) ??
                        timeEnd.value;
                  },
                  child: ValueListenableBuilder(
                    valueListenable: timeEnd,
                    builder: (context, value, __) => SelectTime(time: value),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 16.h,
            ),
            AppButton(
              onPressed: () {
                final event = EventResponse(
                    idEvent: "01",
                    uId: "abc",
                    title: "Đi gặp đối tác khách hàng",
                    content: "Gặp anh xếp bên khách hàng",
                    date: DateTime.now().toFormattedString(),
                    endTime: TimeOfDay.now().toFormattedString(),
                    startTime: TimeOfDay.now().toFormattedString(),
                    status: true);
                _cubit.setEvent(event);
                _cubit.createNewEvent();
              },
              title: widget.event != null ? tr("editSchedule") : tr("add"),
              color: Colors.blue,
              radius: 12.r,
              textStyle: AppTextStyle.textBase.copyWith(color: AppColors.white),
            ),
            SizedBox(
              height: 32.h,
            ),
          ],
        ),
      ),
    );
  }
}
