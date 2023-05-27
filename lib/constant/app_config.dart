class AppConfig {
  static const Map<String, int> schoolStart = {
    'hour': 7,
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

  static const Map<String, double> validLoc = {
    'lat': -7.787484772491008,
    'lng': 110.27771262374408
  };

  static const double presenceRadius = 50;
}