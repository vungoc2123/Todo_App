import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:todo/application/constants/app_colors.dart';
import 'package:todo/application/constants/app_text_style.dart';
import 'package:todo/presentation/screens/focus/bloc/focus_cubit.dart';

class TimeSpinnerWidget extends StatelessWidget {
  const TimeSpinnerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final currentTheme = AdaptiveTheme.of(context).theme;
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 1.sw - 32.r,
          height: 50.h,
          decoration: BoxDecoration(
              color: currentTheme.primaryColor.withOpacity(0.3),
              borderRadius: BorderRadius.circular(8.r)),
        ),
        TimePickerSpinner(
          is24HourMode: true,
          time: DateTime(DateTime.now().year),
          normalTextStyle:
              AppTextStyle.text3Xl.copyWith(color: currentTheme.primaryColor),
          highlightedTextStyle:
              AppTextStyle.text3Xl.copyWith(color: currentTheme.primaryColor),
          spacing: 50.w,
          itemHeight: 80.h,
          alignment: Alignment.center,
          isForce2Digits: true,
          onTimeChange: (time) {
            BlocProvider.of<FocusCubit>(context).handleGetTime(time);
          },
        ),
      ],
    );
  }
}
