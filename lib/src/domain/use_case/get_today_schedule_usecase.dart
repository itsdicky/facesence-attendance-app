import 'package:sistem_presensi/src/domain/repositories/firebase_repository.dart';

class GetTodayScheduleUsecase {
  final FirebaseRepository repository;

  GetTodayScheduleUsecase({required this.repository});

  Future<List> call() async {
    return repository.getTodaySchedule();
  }
}