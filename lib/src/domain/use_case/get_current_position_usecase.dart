import 'package:geolocator/geolocator.dart';
import 'package:sistem_presensi/src/domain/repositories/firebase_repository.dart';

class GetCurrentPositionUseCase {
  final FirebaseRepository repository;

  GetCurrentPositionUseCase({required this.repository});

  Future<Position> call() async {
    return repository.getCurrentPosition();
  }
}