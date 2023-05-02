import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sistem_presensi/feature/domain/entities/presence_entity.dart';
import 'package:sistem_presensi/feature/domain/entities/user_entity.dart';

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
  Stream<List<PresenceEntity>> getPresence(String uid);
}