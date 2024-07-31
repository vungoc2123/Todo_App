class LocaleVi {
  static final Map<String, String> _monthNames = {
    '1': 'Tháng 1',
    '2': 'Tháng 2',
    '3': 'Tháng 3',
    '4': 'Tháng 4',
    '5': 'Tháng 5',
    '6': 'Tháng 6',
    '7': 'Tháng 7',
    '8': 'Tháng 8',
    '9': 'Tháng 9',
    '10': 'Tháng 10',
    '11': 'Tháng 11',
    '12': 'Tháng 12',
  };

  static final Map<int, String> _dayOfWeekNames = {
    DateTime.monday: 'T2',
    DateTime.tuesday: 'T3',
    DateTime.wednesday: 'T4',
    DateTime.thursday: 'T5',
    DateTime.friday: 'T6',
    DateTime.saturday: 'T7',
    DateTime.sunday: 'CN',
  };

  static String monthName(int month) => _monthNames[month.toString()] ?? 'Tháng $month';
  static String dayOfWeekName(int weekday) => _dayOfWeekNames[weekday] ?? 'Ngày $weekday';
}