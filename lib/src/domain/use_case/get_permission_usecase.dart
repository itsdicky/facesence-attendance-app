import 'package:sistem_presensi/src/domain/entities/permission_entity.dart';

import '../repositories/firebase_repository.dart';

class GetPermissionUsecase {
  final FirebaseRepository repository;

  GetPermissionUsecase({required this.repository});

  Stream<List<PermissionEntity>> call() {
    return repository.getCurrentUserWaitingPermission();
  }
}