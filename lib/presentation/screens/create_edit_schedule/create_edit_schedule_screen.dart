import 'package:adaptive_theme/adaptive_theme.dart';
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
    if (widget.event != null) {
      _cubit.setEvent(widget.event!);
    } else {
      _cubit.setEvent(EventResponse(
          date: date.value.toFormattedString(),
          startTime: timeStart.value.toFormattedString(),
          endTime: timeEnd.value.toFormattedString()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentTheme = AdaptiveTheme.of(context).theme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: currentTheme.primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
        title: Text(
          widget.event != null ? tr("editSchedule") : tr("addNewSchedule"),
          style: AppTextStyle.textBase
              .copyWith(fontWeight: FontWeight.w600, color: AppColors.white),
        ),
        foregroundColor: AppColors.white,
        centerTitle: true,
      ),
      backgroundColor: AppColors.gray,
      body: BlocListener<CreateEditScheduleCubit, CreateEditScheduleState>(
        listener: (context, state) {
          if (state.loadStatus == LoadStatus.loading) {
            showDialog(
                context: context,
                builder: (context) => const AppLoading(),
                barrierDismissible: false);
          }
          if (state.loadStatus == LoadStatus.success) {
            Navigator.of(context).pop();
            Navigator.of(context).pop(true);
            AppToast.showToastSuccess(context, title: tr('processSuccess'));
          }
          if (state.loadStatus == LoadStatus.failure) {
            Navigator.of(context).pop();
            AppToast.showToastError(context, title: tr("processFailed"));
          }
        },
        child: Container(
          padding: EdgeInsets.all(12.r),
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomLabelTextField(
                  defaultValue: widget.event?.title ?? "",
                  hintText: tr("title"),
                  onChanged: (value) {
                    _cubit.setEvent(
                        _cubit.state.eventResponse.copyWith(title: value));
                  },
                ),
                CustomLabelTextField(
                  defaultValue: widget.event?.content ?? "",
                  hintText: tr("note"),
                  maxLine: 4,
                  onChanged: (value) {
                    _cubit.setEvent(
                        _cubit.state.eventResponse.copyWith(content: value));
                  },
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
                    _cubit.setEvent(_cubit.state.eventResponse
                        .copyWith(date: date.value.toFormattedString()));
                  },
                  child: ValueListenableBuilder(
                    valueListenable: date,
                    builder: (context, value, __) {
                      return Container(
                        padding: EdgeInsets.all(12.r),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.w),
                            border: Border.all(color: AppColors.grey)),
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
                        _cubit.setEvent(_cubit.state.eventResponse.copyWith(
                            startTime: timeStart.value.toFormattedString()));
                      },
                      child: ValueListenableBuilder(
                        valueListenable: timeStart,
                        builder: (context, value, __) =>
                            SelectTime(time: value),
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
                        _cubit.setEvent(_cubit.state.eventResponse.copyWith(
                            endTime: timeEnd.value.toFormattedString()));
                      },
                      child: ValueListenableBuilder(
                        valueListenable: timeEnd,
                        builder: (context, value, __) =>
                            SelectTime(time: value),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 16.h,
                ),
                AppButton(
                  onPressed: () {
                    if (checkValue(context, _cubit.state.eventResponse)) {
                      if (widget.event != null) {
                        _cubit.updateEvent();
                      } else {
                        _cubit.createNewEvent();
                      }
                    }
                  },
                  title: widget.event != null ? tr("editSchedule") : tr("add"),
                  color: currentTheme.primaryColor,
                  radius: 8.r,
                  height: 40.h,
                  textStyle:
                      AppTextStyle.textBase.copyWith(color: AppColors.white),
                ),
                SizedBox(
                  height: 8.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool checkValue(BuildContext context, EventResponse event) {
    if (event.title == "" || event.content == "") {
      AppToast.showToastError(context, title: tr("requiredInfo"));
      return false;
    }
    if (!timeStart.value.isStartTimeBeforeEndTime(timeEnd.value)) {
      AppToast.showToastError(context, title: tr("requiredTime"));
      return false;
    }
    return true;
  }
}
