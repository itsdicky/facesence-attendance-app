import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sistem_presensi/feature/domain/repositories/firebase_repository.dart';

class GetCurrentUidUsecase {
  final FirebaseRepository repository;

  GetCurrentUidUsecase({required this.repository});

  Future<String> call() async {
    return repository.getCurrentUserId();
  }
}