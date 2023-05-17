import 'package:sistem_presensi/src/domain/entities/permission_entity.dart';
import 'package:sistem_presensi/src/domain/repositories/firebase_repository.dart';

class AddNewPermissionUseCase {
  final FirebaseRepository repository;

  AddNewPermissionUseCase({required this.repository});

  Future<void> call(PermissionEntity permission) async {
    return repository.addNewPermission(permission);
  }
}