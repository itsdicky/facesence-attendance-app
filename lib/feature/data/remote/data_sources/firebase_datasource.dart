import 'package:sistem_presensi/feature/domain/entities/presence_entity.dart';
import 'package:sistem_presensi/feature/domain/entities/user_entity.dart';

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
  Stream<List<PresenceEntity>> getPresence(String uid);
}