import 'package:sistem_presensi/src/domain/entities/presence_entity.dart';
import 'package:sistem_presensi/src/domain/entities/user_entity.dart';

abstract class FirebaseDataSource {
  Future<bool> isSignIn();
  Future<void> signIn(UserEntity userEntity);
  Future<void> signUp(UserEntity userEntity);
  Future<void> getCreateCurrentUser(UserEntity userEntity);
  Future<void> signOut();
  Future<String> getCurrentUserId();
  Future<void> addNewPresence(PresenceEntity presenceEntity);
  Future<void> update(PresenceEntity presenceEntity);
  Future<void> delete(PresenceEntity presenceEntity);
  Future<UserEntity> getCurrentUser();
  Stream<List<PresenceEntity>> getPresence(String uid);
}