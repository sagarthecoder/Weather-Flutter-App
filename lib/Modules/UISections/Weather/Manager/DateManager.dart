import 'package:intl/intl.dart';

final class DateManager {
  DateManager._internal();
  static final DateManager shared = DateManager._internal();

  DateTime unixTimestampToLocalDateTime(int timestamp) {
    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(timestamp * 1000, isUtc: true);
    // Convert to local time
    DateTime localDateTime = dateTime.toLocal();
    return localDateTime;
  }

  String getTimeInfoFromDateTime(DateTime dateTime) {
    return DateFormat('hh:mm a').format(dateTime);
  }
}
