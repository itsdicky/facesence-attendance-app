import 'package:geolocator/geolocator.dart';
import 'package:sistem_presensi/src/domain/entities/permission_entity.dart';
import 'package:sistem_presensi/src/domain/entities/presence_entity.dart';
import 'package:sistem_presensi/src/domain/entities/user_entity.dart';

abstract class FirebaseRepository {
  Future<bool> isSignIn();
  Future<void> signIn(UserEntity user);
  Future<void> signUp(UserEntity user);
  Future<void> getCreateCurrentUser(UserEntity user);
  Future<void> signOut();
  Future<String> getCurrentUserId();
  Future<void> addNewPresence(PresenceEntity presence);
  Future<void> addNewPermission(PermissionEntity permission);
  Future<UserEntity> getCurrentUser();
  Future<List> getTodaySchedule();
  Future<Position> getCurrentPosition();
  Future<void> deleteAll(String collectionName);
  // Stream<List> activity();
  Stream<List<PresenceEntity>> getCurrentUserPresences();
  Stream<List<PermissionEntity>> getCurrentUserWaitingPermission();
}