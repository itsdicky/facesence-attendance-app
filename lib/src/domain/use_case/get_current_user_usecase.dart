import 'package:sistem_presensi/src/domain/entities/user_entity.dart';
import 'package:sistem_presensi/src/domain/repositories/firebase_repository.dart';

class GetCurrentUserUsecase {
  final FirebaseRepository repository;

  GetCurrentUserUsecase({required this.repository});

  Future<UserEntity> call() async {
    return repository.getCurrentUser();
  }
}