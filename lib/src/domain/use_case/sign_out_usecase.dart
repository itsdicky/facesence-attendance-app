import 'package:sistem_presensi/src/domain/repositories/firebase_repository.dart';

class SignOutUsecase {
  final FirebaseRepository repository;

  SignOutUsecase({required this.repository});

  Future<void> call() async {
    return repository.signOut();
  }
}