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
  Future<void> update(PresenceEntity presence);
  Future<void> delete(PresenceEntity presence);
  Future<UserEntity> getCurrentUser();
  Future<List> getTodaySchedule();
  Stream<List<PresenceEntity>> getPresence(String uid);
}