String formatDuration(int? minutes) {
  if (minutes == null) return '30 mins';
  if (minutes < 60) return '$minutes mins';
  final hours = minutes ~/ 60;
  final remainingMins = minutes % 60;
  if (remainingMins == 0) return '$hours hr';
  return '$hours hr $remainingMins mins';
}

String? capitalize(String? text) {
  if (text == null || text.isEmpty) return null;
  return text[0].toUpperCase() + text.substring(1);
}
