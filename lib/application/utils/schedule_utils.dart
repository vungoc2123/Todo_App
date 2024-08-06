import 'package:easy_localization/easy_localization.dart';

class LocaleVi {
  static final Map<String, String> _monthNames = {
    '1': tr('t1'),
    '2': tr('t2'),
    '3': tr('t3'),
    '4': tr('t4'),
    '5': tr('t5'),
    '6': tr('t6'),
    '7': tr('t7'),
    '8': tr('t8'),
    '9': tr('t9'),
    '10': tr('t10'),
    '11': tr('t11'),
    '12': tr('t12'),
  };

  static final Map<int, String> _dayOfWeekNames = {
    DateTime.monday: tr('T2'),
    DateTime.tuesday: tr('T3'),
    DateTime.wednesday: tr('T4'),
    DateTime.thursday: tr('T5'),
    DateTime.friday: tr('T6'),
    DateTime.saturday: tr('T7'),
    DateTime.sunday: tr('CN'),
  };

  static String monthName(int month) => _monthNames[month.toString()] ?? '${tr("month")} $month';
  static String dayOfWeekName(int weekday) => _dayOfWeekNames[weekday] ?? 'Ngày $weekday';
}