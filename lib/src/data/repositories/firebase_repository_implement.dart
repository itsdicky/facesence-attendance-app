import 'package:sistem_presensi/src/data/remote/data_sources/firebase_datasource.dart';
import 'package:sistem_presensi/src/domain/entities/presence_entity.dart';
import 'package:sistem_presensi/src/domain/entities/user_entity.dart';
import 'package:sistem_presensi/src/domain/repositories/firebase_repository.dart';

class FireBaseRepositoryImplement extends FirebaseRepository {
  final FirebaseDataSource dataSource;

  FireBaseRepositoryImplement({required this.dataSource});

  @override
  Future<void> addNewPresence(PresenceEntity presence) async {
    await dataSource.addNewPresence(presence).then((uid) async {
      if (uid!=null) {
        await dataSource.incrementTotalPresence(uid);
      }
    });
  }

  @override
  Future<void> delete(PresenceEntity presence) async =>
      dataSource.delete(presence);

  @override
  Future<String> getCurrentUserId() async =>
      dataSource.getCurrentUserId();

  @override
  Stream<List<PresenceEntity>> getCurrentUserPresences() async* {
    final uid = await getCurrentUserId();
    yield* dataSource.getUserPresences(uid);
  }

  @override
  Future<bool> isSignIn() async =>
      dataSource.isSignIn();

  @override
  Future<void> signIn(UserEntity user) async =>
      dataSource.signIn(user);

  @override
  Future<void> signOut() async =>
      dataSource.signOut();

  @override
  Future<void> signUp(UserEntity user) async =>
      dataSource.signUp(user);

  @override
  Future<void> update(PresenceEntity presence) async =>
      dataSource.update(presence);

  @override
  Future<void> getCreateCurrentUser(UserEntity user) async =>
      dataSource.getCreateCurrentUser(user);

  @override
  Future<UserEntity> getCurrentUser() async =>
      dataSource.getCurrentUser();

  @override
  Future<List> getTodaySchedule() async => dataSource.getTodaySchedule();

}