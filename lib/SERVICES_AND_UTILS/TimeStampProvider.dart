import 'package:date_format/date_format.dart';

abstract class TimeStampProvider {
  static String timeStampProvider(String giventime) {
    DateTime _givenTime = DateTime.parse(giventime).toLocal();
    DateTime _timeNow = DateTime.now();
    int _difference = _timeNow.difference(_givenTime).inMinutes.toInt();
    print((_timeNow.day-_givenTime.day));
    if (_difference == 0) {
      return "Just now";
    } else if (_givenTime.day == _timeNow.day) {
      return formatDate(_givenTime, [hh, ':', nn, ' ', am]);
    } else if ((_timeNow.day-_givenTime.day) == 1) {
      return formatDate(_givenTime, [hh, ':', nn, ' ', am]) + " Yesterday";
    } else if (_givenTime.year == _timeNow.year) {
      return formatDate(_givenTime, [hh, ':', nn, ' ', am]) +
          " " +
          formatDate(_givenTime, [d, '-', M]);
    } else {
      return formatDate(_givenTime, [hh, ':', nn, ' ', am]) +
          " " +
          formatDate(_givenTime, [d, '-', M, '-', yy]);
    }
    //else if (_difference > 0 && _difference <= 59) {
    //   return "${_difference}m";
    // } else if (_difference >= 60 && _difference / 60 <= 24) {
    //   return "${(_difference ~/ 60)}h";
    // } else if ((_difference / 60) / 24 < 2) {
    //   return "${(_difference ~/ 60) ~/ 24}d";
    // } else if ((_difference / 60) / 24 <= 30) {
    //   return "${(_difference ~/ 60) ~/ 24}d";
    // } else {
    //   return "${_givenTime.day}/${_givenTime.month}/${_givenTime.year}";
    // }
  }
}
