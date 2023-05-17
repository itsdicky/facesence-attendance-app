import 'package:sistem_presensi/src/domain/entities/presence_entity.dart';

class CDateUtil {
  static bool _isExactDate(DateTime? date, DateTime? otherDate) {
    bool result = date?.day == otherDate?.day && date?.month == otherDate?.month && date?.year == otherDate?.year;
    return result;
  }

  static Iterable<PresenceEntity> filterPresenceDateList(List<PresenceEntity> list, DateTime date) {
    Iterable<PresenceEntity> result = list.where((presence) => _isExactDate(presence.time?.toDate(), date));
    return result;
  }
}