abstract class TimeStampProvider {
  static String timeStampProvider(String giventime) {
    DateTime _givenTime = DateTime.parse(giventime);
    DateTime _timeNow = DateTime.now();

    int _difference = _timeNow.difference(_givenTime).inMinutes.toInt();
    if (_difference == 0) {
      return "Just now";
    } else if (_difference > 0 && _difference <= 59) {
      return "$_difference min ago";
    } else if (_difference >= 60 && _difference / 60 <= 24) {
      return "${(_difference ~/ 60)} hr ago";
    } else if ((_difference / 60) / 24 <2) {
      return "${(_difference ~/ 60) ~/ 24} day ago";
    } else if ((_difference / 60) / 24 <= 30) {
      return "${(_difference ~/ 60) ~/ 24} days ago";
    } else {
      return "${_givenTime.day}/${_givenTime.month}/${_givenTime.year}";
    }
  }
}
