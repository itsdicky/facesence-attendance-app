import 'package:sistem_presensi/src/domain/repositories/firebase_repository.dart';

class GetCurrentUidUsecase {
  final FirebaseRepository repository;

  GetCurrentUidUsecase({required this.repository});

  Future<String> call() async {
    return repository.getCurrentUserId();
  }
}