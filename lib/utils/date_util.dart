import 'package:intl/intl.dart';
import 'package:sistem_presensi/src/domain/entities/presence_entity.dart';

class CDateUtil {
  static bool isExactDate(DateTime? date, DateTime? otherDate) {
    bool result = date?.day == otherDate?.day && date?.month == otherDate?.month && date?.year == otherDate?.year;
    return result;
  }

  static Iterable<PresenceEntity> filterPresenceDateList(List<PresenceEntity> list, DateTime date) {
    Iterable<PresenceEntity> result = list.where((presence) => isExactDate(presence.time?.toDate(), date));
    return result;
  }

  static String getFormattedDateTimeString(DateTime dateTime) {
    DateFormat format = new DateFormat("dd MMMM yyyy");
    String formattedDate = format.format(dateTime);
    String time = getTimeString(dateTime);
    String result = '$formattedDate, $time WIB';
    return result;
  }

  static String getTimeString(DateTime dateTime) {
    String hour = dateTime.hour.checkLength(1) ? dateTime.hour.addZeroPrefix(2):dateTime.hour.toString();
    String minute = dateTime.minute.checkLength(1) ? dateTime.minute.addZeroPrefix(2):dateTime.minute.toString();

    String result = '$hour:$minute';
    return result;
  }

  static bool isTimeAfter({required DateTime dateTime, required int hour, required int minute}) {
    if (minute == 0) {
      return dateTime.hour >= hour;
    } else {
      return dateTime.hour >= hour && dateTime.minute >= minute;
    }
  }
}

extension extInt on int {
  bool checkLength(int length) {
    return toString().length == length;
  }

  String addZeroPrefix(int digit) {
    final String resultString = toString().padLeft(digit, '0');
    return resultString;
  }
}