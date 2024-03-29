import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String formatDate(int millSecondsFromEpoch) {
  return DateFormat.yMMMd()
      .format(DateTime.fromMillisecondsSinceEpoch(millSecondsFromEpoch));
}

String formatTime(BuildContext context, int hour, int minute) {
  return TimeOfDay(hour: hour, minute: minute).format(context);
}

void showSnackBar(BuildContext context, String message) {
  final snackBar = SnackBar(
    content: Text('$message',
      style: TextStyle(color: Theme.of(context).colorScheme.secondary)),
    duration: Duration(seconds: 1),
    backgroundColor: Theme.of(context).cardColor,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
