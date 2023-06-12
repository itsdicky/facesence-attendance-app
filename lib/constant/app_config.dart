class AppConfig {
  static const Map<String, int> schoolStart = {
    'hour': 7,
    'minute': 0
  };

  static const Map<String, int> presenceStart = {
    'hour': 6,
    'minute': 0
  };

  static const List<String> schTime = [
    '07:30-09:10',
    '09:10-10:30',
    '10:30-12:00',
    '12:00-13:40',
    '13:40-14:30'
  ];

  static const List<String> permissionCategory = [
    'Izin',
    'Sakit',
    'Kegiatan sekolah',
    'Lain-lain',
  ];

  static const List<String> classroom = [
    'XI IPA 1',
    'XI IPA 2',
    'XI IPS 1',
    'XI IPS 2'
  ];

  static const Map<String, double> validLoc = {
    'lat': -7.730793854206757,
    'lng': 110.38655934062481
  };

  static const double presenceRadius = 50;
}