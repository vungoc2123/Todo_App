extension IntFormat on double {
  String formatMinutes() {
    int hours = (this ~/ 60);
    int minutes = (this % 60).ceil();
    String formattedHours = hours.toString().padLeft(2, '0');
    String formattedMinutes = minutes.toString().padLeft(2, '0');

    return '$formattedHours:$formattedMinutes';
  }
}
