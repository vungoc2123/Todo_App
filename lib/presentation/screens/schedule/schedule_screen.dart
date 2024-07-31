import 'package:easy_localization/easy_localization.dart';
import 'package:entry/entry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo/application/constants/app_colors.dart';
import 'package:todo/application/constants/app_text_style.dart';
import 'package:todo/application/extensions/date_time_extension.dart';
import 'package:todo/application/utils/schedule_utils.dart';
import 'package:todo/domain/models/response/schedule/event_response.dart';
import 'package:todo/presentation/common_widgets/app_bottom_sheet.dart';
import 'package:todo/presentation/screens/create_edit_schedule/create_edit_schedule_cubit.dart';
import 'package:todo/presentation/screens/create_edit_schedule/create_edit_schedule_screen.dart';
import 'package:todo/presentation/screens/schedule/widgets/detail_schedule.dart';
import 'package:todo/presentation/screens/schedule/widgets/schedule_widget.dart';

final event = EventResponse(
    idEvent: "01",
    uId: "abc",
    title: "Đi gặp đối tác khách hàng",
    content: "Gặp anh xếp bên khách hàng",
    date: DateTime.now().toFormattedString(),
    endTime: TimeOfDay.now().toFormattedString(),
    startTime: TimeOfDay.now().toFormattedString(),
    status: true);
final event1 = EventResponse(
    title: "Đi gặp đối tác khách hàng, Đi gặp đối tác khách hàng",
    idEvent: "01",
    uId: "abc",
    content:
        "Gặp anh xếp bên khách hàng,Gặp anh xếp bên khách hàng,Gặp anh xếp bên khách hàng,Gặp anh xếp bên khách hàng",
    date: DateTime.now().toFormattedString(),
    endTime: TimeOfDay.now().toFormattedString(),
    startTime: TimeOfDay.now().toFormattedString(),
    status: false);
final listEvents = [
  event,
  event1,
  event,
  event1,
  event,
  event1,
  event,
  event1,
  event,
  event1,
  event,
  event1,
  event,
  event1,
  event,
  event1,
  event,
  event1,
];

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen>
    with SingleTickerProviderStateMixin {
  late ValueNotifier<DateTime> _selectedDay;
  late ValueNotifier _focusedDay;
  TextEditingController controller = TextEditingController();
  late ValueNotifier<List<EventResponse>> _selectedEvents;
  final ValueNotifier<CalendarFormat> _formatNotifier =
      ValueNotifier(CalendarFormat.week);
  Map<DateTime, List<EventResponse>> events = {};

  @override
  void initState() {
    super.initState();
    _selectedDay = ValueNotifier<DateTime>(DateTime.now());
    _focusedDay = ValueNotifier(DateTime.now());
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay.value));
  }

  @override
  void dispose() {
    super.dispose();
    _focusedDay.dispose();
    _selectedDay.dispose();
    _selectedEvents.dispose();
  }

  List<EventResponse> _getEventsForDay(DateTime selectedDay) {
    return events[selectedDay] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.gray,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ValueListenableBuilder(
              valueListenable: _selectedDay,
              builder: (context, _, __) {
                return ValueListenableBuilder(
                  valueListenable: _focusedDay,
                  builder: (context, _, __) {
                    return ValueListenableBuilder<CalendarFormat>(
                      valueListenable: _formatNotifier,
                      builder: (context, value, _) {
                        return AnimatedCrossFade(
                          duration: const Duration(milliseconds: 400),
                          firstChild: _buildTableCalendar(CalendarFormat.month),
                          secondChild: _buildTableCalendar(CalendarFormat.week),
                          crossFadeState: value == CalendarFormat.week
                              ? CrossFadeState.showFirst
                              : CrossFadeState.showSecond,
                        );
                      },
                    );
                  },
                );
              },
            ),
            SizedBox(
              height: 12.h,
            ),
            // Expanded(
            //   child: ValueListenableBuilder(
            //       valueListenable: _selectedEvents,
            //       builder: (context, value, __) {
            //         return ListView.separated(
            //             itemBuilder: (context, index) {
            //               return Text(value[index].title);
            //             },
            //             separatorBuilder: (_, __) {
            //               return SizedBox(
            //                 height: 12.h,
            //               );
            //             },
            //             itemCount: value.length);
            //       }),
            // )
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
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                        InkWell(
                          onTap: () {
                            AppBottomSheet.showBottomSheet(context,
                                child: BlocProvider(
                                    create: (context)=> CreateEditScheduleCubit(),
                                    child: const EditSchedule()));
                            // showDialog(
                            //     context: context,
                            //     builder: (context) {
                            //       return AlertDialog(
                            //         title: const Text("Create Event"),
                            //         content: TextField(
                            //           controller: controller,
                            //         ),
                            //         actions: [
                            //           ElevatedButton(
                            //               onPressed: () {
                            //                 // events.addAll({
                            //                 //   _selectedDay.value!: [
                            //                 //     Event(title: controller.text)
                            //                 //   ]
                            //                 // });
                            //                 if (events[_selectedDay.value] != null) {
                            //                   // Thêm sự kiện vào danh sách các sự kiện hiện có
                            //                   events[_selectedDay.value]!
                            //                       .add(Event(title: controller.text));
                            //                 } else {
                            //                   // Nếu chưa có sự kiện, tạo danh sách mới
                            //                   events[_selectedDay.value] = [
                            //                     Event(title: controller.text)
                            //                   ];
                            //                 }
                            //                 _selectedEvents.value =
                            //                     _getEventsForDay(_selectedDay.value);
                            //                 Navigator.of(context).pop();
                            //               },
                            //               child: const Text("Submit"))
                            //         ],
                            //       );
                            //     });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.r, vertical: 4.r),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                color: Colors.lightBlue),
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
            Expanded(
                child: ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 16.r),
                    itemBuilder: (context, index) => Entry.all(
                          delay: const Duration(milliseconds: 100),
                          child: InkWell(
                              onTap: () {
                                AppBottomSheet.showBottomSheet(context,
                                    child: DetailSchedule(
                                      event: listEvents[index],
                                    ));
                              },
                              child: ScheduleWidget(event: listEvents[index])),
                        ),
                    separatorBuilder: (_, __) {
                      return SizedBox(
                        height: 16.h,
                      );
                    },
                    itemCount: listEvents.length)),
            SizedBox(
              height: 8.h,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTableCalendar(CalendarFormat format) {
    return TableCalendar(
      firstDay: DateTime.utc(2010, 10, 16),
      lastDay: DateTime.utc(2030, 3, 14),
      focusedDay: _selectedDay.value,
      calendarFormat: format,
      availableCalendarFormats: const {
        CalendarFormat.week: 'week',
        CalendarFormat.month: 'Month',
      },
      calendarStyle: CalendarStyle(
        todayDecoration: const BoxDecoration(
          color: Colors.lightBlue,
          shape: BoxShape.circle,
        ),
        selectedDecoration: const BoxDecoration(
          color: Colors.orange,
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
        _selectedEvents.value = _getEventsForDay(selectedDay);
      },
    );
  }
}
