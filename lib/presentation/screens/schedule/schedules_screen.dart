import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:entry/entry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo/application/constants/app_colors.dart';
import 'package:todo/application/constants/app_text_style.dart';
import 'package:todo/application/enums/load_status.dart';
import 'package:todo/application/extensions/date_time_extension.dart';
import 'package:todo/application/utils/schedule_utils.dart';
import 'package:todo/domain/models/response/schedule/event_response.dart';
import 'package:todo/gen/assets.gen.dart';
import 'package:todo/presentation/common_widgets/app_bottom_sheet.dart';
import 'package:todo/presentation/common_widgets/app_loading_indicator.dart';
import 'package:todo/presentation/routes/route_name.dart';
import 'package:todo/presentation/screens/detail_schedule/detail_schedule_cubit.dart';
import 'package:todo/presentation/screens/schedule/schedule_cubit.dart';
import 'package:todo/presentation/screens/schedule/schedules_state.dart';
import 'package:todo/presentation/screens/detail_schedule/detail_schedule.dart';
import 'package:todo/presentation/screens/schedule/widgets/schedule_widget.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  late SchedulesCubit _cubit;
  late ValueNotifier<DateTime> _selectedDay;
  late ValueNotifier _focusedDay;
  final ValueNotifier<CalendarFormat> _formatNotifier =
      ValueNotifier(CalendarFormat.week);
  Map<DateTime, List<EventResponse>> events = {};

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of<SchedulesCubit>(context);
    _cubit.getEventByDate(DateTime.now().toFormattedString());
    _cubit.getAllEvent();
    _selectedDay = ValueNotifier<DateTime>(DateTime.now());
    _focusedDay = ValueNotifier(DateTime.now());
  }

  @override
  void dispose() {
    super.dispose();
    _focusedDay.dispose();
    _selectedDay.dispose();
  }

  void _addEventToSchedule() {
    events.clear();
    for (var x in _cubit.state.allEvents) {
      final date = x.date.toDateTime().toUtc();
      if (events[date] != null) {
        events[date]?.add(x);
      } else {
        events[date] = [x];
      }
    }
  }

  List<EventResponse> _getEventsForDay(DateTime selectedDay) {
    return events[selectedDay] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    final currentTheme = AdaptiveTheme.of(context).theme;

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.grayF3,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocConsumer<SchedulesCubit, SchedulesState>(
              listenWhen: (pre, cur) => pre.loadAllStatus != cur.loadAllStatus,
              listener: (context, state) {
                _addEventToSchedule();
              },
              buildWhen: (pre, cur) => pre.loadAllStatus != cur.loadAllStatus,
              builder: (context, state) {
                if (state.loadAllStatus == LoadStatus.success) {
                  return ValueListenableBuilder(
                    valueListenable: _selectedDay,
                    builder: (context, _, __) {
                      return ValueListenableBuilder(
                        valueListenable: _focusedDay,
                        builder: (context, _, __) {
                          return ValueListenableBuilder<CalendarFormat>(
                            valueListenable: _formatNotifier,
                            builder: (context, value, _) {
                              return _buildTableCalendar(value,currentTheme.primaryColor);
                            },
                          );
                        },
                      );
                    },
                  );
                }
                if (state.loadAllStatus == LoadStatus.failure) {
                  return Center(
                    child: Text(
                      tr('error'),
                      style: AppTextStyle.textXs,
                    ),
                  );
                }
                return Center(
                  child: SizedBox(
                    height: 120.h,
                    child: const AppLoadingIndicator(
                      color: AppColors.colorPrimary,
                    ),
                  ),
                );
              },
            ),
            SizedBox(
              height: 12.h,
            ),
            ValueListenableBuilder(
              valueListenable: _selectedDay,
              builder: (context, value, __) {
                return Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.r, vertical: 8.h),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${tr("schedule")}: ${value.toFormattedString()}',
                          style: AppTextStyle.textBase
                              .copyWith(fontWeight: FontWeight.w300),
                        ),
                        InkWell(
                          onTap: () async {
                            final result = await Navigator.of(context)
                                .pushNamed(RouteName.createEditSchedule);
                            if (result is bool && result == true) {
                              _cubit.getEventByDate(
                                  _selectedDay.value.toFormattedString());
                              _cubit.getAllEvent();
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.r, vertical: 4.r),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.r),
                                color: currentTheme.primaryColor),
                            child: Text(
                              tr("add"),
                              style: AppTextStyle.textSm
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        )
                      ]),
                );
              },
            ),
            SizedBox(
              height: 8.h,
            ),
            BlocBuilder<SchedulesCubit, SchedulesState>(
              buildWhen: (pre, cur) => pre.loadStatus != cur.loadStatus,
              builder: (context, state) {
                if (state.loadStatus == LoadStatus.success) {
                  if (state.events.isEmpty) {
                    return Expanded(
                        child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            Assets.images.imgCalendar.path,
                            width: 75.r,
                            height: 75.r,
                          ),
                          Text(
                            tr('youHaveFreeDay'),
                            style: AppTextStyle.textXs,
                          )
                        ],
                      ),
                    ));
                  }
                  return Expanded(
                      child: ListView.separated(
                          padding: EdgeInsets.symmetric(horizontal: 16.r),
                          itemBuilder: (context, index) => Entry.all(
                                delay: const Duration(milliseconds: 100),
                                child: InkWell(
                                    onTap: () async {
                                      final result =
                                          await AppBottomSheet.showBottomSheet(
                                              context,
                                              child: BlocProvider(
                                                create: (context) =>
                                                    DetailScheduleCubit(),
                                                child: DetailSchedule(
                                                  event: state.events[index],
                                                ),
                                              ));
                                      if (result == true) {
                                        _cubit.getEventByDate(_selectedDay.value
                                            .toFormattedString());
                                        _cubit.getAllEvent();
                                      }
                                    },
                                    child: ScheduleWidget(
                                        event: state.events[index])),
                              ),
                          separatorBuilder: (_, __) {
                            return SizedBox(
                              height: 16.h,
                            );
                          },
                          itemCount: state.events.length));
                }
                if (state.loadStatus == LoadStatus.failure) {
                  return Expanded(
                      child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          Assets.images.imgWarning.path,
                          width: 60.r,
                          height: 60.r,
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        Text(
                          tr('error'),
                          style: AppTextStyle.textXs,
                        )
                      ],
                    ),
                  ));
                }
                return const Expanded(
                  child: Center(
                      child: AppLoadingIndicator(
                    color: AppColors.colorPrimary,
                  )),
                );
              },
            ),
            SizedBox(
              height: 8.h,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTableCalendar(CalendarFormat format,Color colorMarker) {
    return TableCalendar(
      firstDay: DateTime.utc(2010, 10, 16),
      lastDay: DateTime.utc(2030, 3, 14),
      focusedDay: _selectedDay.value,
      calendarFormat: format,
      availableCalendarFormats: const {
        CalendarFormat.month: 'week',
        CalendarFormat.week: 'Month',
      },
      calendarStyle: CalendarStyle(
        markersMaxCount: 1,
        markerDecoration: const BoxDecoration(
          color: AppColors.red,
          shape: BoxShape.circle,
        ),
        todayDecoration: const BoxDecoration(
          color: Colors.lightBlue,
          shape: BoxShape.circle,
        ),
        selectedDecoration:  BoxDecoration(
          color: colorMarker,
          shape: BoxShape.circle,
        ),
        defaultTextStyle: AppTextStyle.textXs,
        weekendTextStyle: AppTextStyle.textXs.copyWith(color: Colors.red),
      ),
      formatAnimationDuration: const Duration(milliseconds: 500),
      formatAnimationCurve: Curves.easeInOut,
      pageAnimationDuration: const Duration(milliseconds: 400),
      pageAnimationCurve: Curves.fastOutSlowIn,
      onFormatChanged: (newFormat) {
        if (_formatNotifier.value != newFormat) {
          _formatNotifier.value = newFormat;
        }
      },
      headerStyle: HeaderStyle(
        titleTextFormatter: (date, locale) => LocaleVi.monthName(date.month),
        formatButtonVisible: false,
      ),
      calendarBuilders:
          CalendarBuilders(headerTitleBuilder: (context, focusedDay) {
        return Center(
          child: Text(
            '${LocaleVi.monthName(focusedDay.month)} ${focusedDay.year}',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        );
      }, dowBuilder: (context, date) {
        return Center(child: Text(LocaleVi.dayOfWeekName(date.weekday)));
      }),
      eventLoader: _getEventsForDay,
      selectedDayPredicate: (day) {
        return isSameDay(_selectedDay.value, day);
      },
      onDaySelected: (selectedDay, focusedDay) {
        _selectedDay.value = selectedDay;
        _focusedDay.value = focusedDay;
        _cubit.getEventByDate(_selectedDay.value.toFormattedString());
      },
    );
  }
}
