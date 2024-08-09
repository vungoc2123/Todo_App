import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/application/constants/app_colors.dart';
import 'package:todo/application/constants/app_text_style.dart';
import 'package:todo/application/enums/load_status.dart';
import 'package:todo/application/extensions/date_time_extension.dart';
import 'package:todo/gen/assets.gen.dart';
import 'package:todo/presentation/common_widgets/app_loading_indicator.dart';
import 'package:todo/presentation/screens/report_focus/report_focus_cubit.dart';
import 'package:todo/presentation/screens/report_focus/report_focus_state.dart';



class ReportFocusWidget extends StatefulWidget {
  const ReportFocusWidget({
    super.key,
  });

  @override
  State<ReportFocusWidget> createState() => _ReportFocusWidgetState();
}

class _ReportFocusWidgetState extends State<ReportFocusWidget> {
  late ReportFocusCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of<ReportFocusCubit>(context);
    _cubit.setFromDate(DateTime.now());
    _cubit.setDates(getLast5Days(_cubit.state.fromDate!));
    _cubit.getData();
  }

  @override
  Widget build(BuildContext context) {
    final currentTheme =
        AdaptiveTheme.of(context).theme;
    return Container(
      padding: EdgeInsets.all(12.h),
      decoration: BoxDecoration(
          color: AppColors.white, borderRadius: BorderRadius.circular(8.r)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Assets.icons.iconReport.svg(
              width: 20,
              height: 20,
              colorFilter:
                  ColorFilter.mode(currentTheme.primaryColor, BlendMode.srcIn),
            ),
            SizedBox(
              width: 12.w,
            ),
            Text(
              tr('reportTimeFocus'),
              style: AppTextStyle.textSm.copyWith(
                  color: AppColors.textPrimary, fontWeight: FontWeight.w400),
            ),
          ]),
          SizedBox(
            height: 28.h,
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  _cubit.setFromDate(_cubit.state.fromDate!.subtract(const Duration(days: 5)));
                  _cubit.setDates(getLast5Days(_cubit.state.fromDate!));
                  _cubit.getData();
                },
                child: ClipOval(
                  child: Container(
                      padding: EdgeInsets.all(4.r),
                      color: AppColors.white,
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: currentTheme.primaryColor,
                        size: 16.r,
                      )),
                ),
              ),
              BlocBuilder<ReportFocusCubit, ReportFocusState>(
                builder: (context, state) {
                  if (state.loadStatus == LoadStatus.failure) {
                    return Center(
                      child: Text(tr("error")),
                    );
                  }
                  if (state.loadStatus == LoadStatus.success) {
                    return Expanded(
                      child: AspectRatio(
                          aspectRatio: 1.6,
                          child: BarChart(
                            BarChartData(
                              barTouchData: barTouchData(currentTheme),
                              titlesData: titlesData,
                              borderData: borderData,
                              barGroups: List.generate(
                                  state.data.length,
                                  (index) =>
                                      BarChartGroupData(x: index, barRods: [
                                        BarChartRodData(
                                          toY: state.data[index].time,
                                          gradient: _barsGradient(currentTheme),
                                        ),
                                      ], showingTooltipIndicators: [
                                        0
                                      ])),
                              gridData: const FlGridData(show: true),
                              alignment: BarChartAlignment.spaceAround,
                              // maxY: 480,
                            ),
                            swapAnimationDuration:
                                const Duration(milliseconds: 500),
                          )),
                    );
                  }
                  return SizedBox(
                      width: 1.sw - 102.w ,
                      height: 175.h,
                      child: const AppLoadingIndicator());
                },
              ),
              GestureDetector(
                onTap: () {
                  _cubit.setFromDate(_cubit.state.fromDate!.add(const Duration(days: 5)));
                  _cubit.setDates(getLast5Days(_cubit.state.fromDate!));
                  _cubit.getData();
                },
                child: ClipOval(
                  child: Container(
                      padding: EdgeInsets.all(4.r),
                      color: AppColors.white,
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: currentTheme.primaryColor,
                        size: 16.r,
                      )),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  BarTouchData barTouchData(ThemeData currentTheme) => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          getTooltipColor: (group) => Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 8,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.toY.round().toString(),
              TextStyle(
                color: currentTheme.indicatorColor,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  Widget getTitles(double value, TitleMeta meta) {
    List<String> days = getLast5Days(_cubit.state.fromDate!);
    String text;

    if (value.toInt() >= 0 && value.toInt() < days.length) {
      String date = days[value.toInt()];
      text = date.substring(0, 5);
    } else {
      text = '';
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text,
          style: AppTextStyle.textXs.copyWith(
              color: AppColors.blueBold, fontWeight: FontWeight.w200)),
    );
  }

  List<String> getLast5Days(DateTime dateTime) {
    return List.generate(
        5,
        (index) =>
            dateTime.subtract(Duration(days: 4 - index)).toFormattedString());
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: getTitles,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  FlBorderData get borderData => FlBorderData(
        show: false,
      );

  LinearGradient _barsGradient(ThemeData currentTheme) => LinearGradient(
        colors: [
          currentTheme.primaryColor,
          currentTheme.indicatorColor,
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );

  List<BarChartGroupData> barGroupData(ThemeData currentTheme) => List.generate(
      _cubit.state.data.length,
      (index) => BarChartGroupData(x: index, barRods: [
            BarChartRodData(
              toY: _cubit.state.data[index].time,
              gradient: _barsGradient(currentTheme),
            ),
          ], showingTooltipIndicators: [
            0
          ]));
}
