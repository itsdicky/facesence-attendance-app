import 'package:sistem_presensi/src/domain/entities/permission_entity.dart';
import 'package:sistem_presensi/src/domain/entities/presence_entity.dart';
import 'package:sistem_presensi/src/domain/entities/user_entity.dart';

abstract class FirebaseDataSource {
  Future<bool> isSignIn();
  Future<void> signIn(UserEntity userEntity);
  Future<void> signUp(UserEntity userEntity);
  Future<void> getCreateCurrentUser(UserEntity userEntity);
  Future<void> signOut();
  Future<String> getCurrentUserId();
  Future<String?> addNewPresence(PresenceEntity presenceEntity);
  Future<String?> addNewPermission(PermissionEntity permissionEntity);
  Future<UserEntity> getCurrentUser();
  Future<List> getTodaySchedule();
  Future<void> incrementTotalPresence(String uid);
  Future<void> deleteAll(String collectionName);
  Stream<List<PresenceEntity>> getUserPresences(String uid);
  Stream<List<PermissionEntity>> getUserWaitingPermission(String uid);
}