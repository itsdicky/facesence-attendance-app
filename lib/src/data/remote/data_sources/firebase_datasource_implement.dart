import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sistem_presensi/src/data/remote/data_sources/firebase_datasource.dart';
import 'package:sistem_presensi/src/data/remote/model/presence_model.dart';
import 'package:sistem_presensi/src/data/remote/model/user_model.dart';
import 'package:sistem_presensi/src/domain/entities/presence_entity.dart';
import 'package:sistem_presensi/src/domain/entities/user_entity.dart';

class FirebaseDataSourceImplement extends FirebaseDataSource {

  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  FirebaseDataSourceImplement({required this.auth, required this.firestore});

  @override
  Future<void> addNewPresence(PresenceEntity presenceEntity) async {
    final CollectionReference presenceCollectionRef = firestore.collection('presence');
    final presenceId = presenceCollectionRef.doc(presenceEntity.uid).id;
    //get current user id

    await presenceCollectionRef.doc(presenceId).get().then((presence){
      final newPresence = PresenceModel(presenceId: presenceId, uid: presenceEntity.uid).toDocument();
      if(!presence.exists) {
        presenceCollectionRef.doc(presenceId).set(newPresence);
      }
      return;
    });
  }

  @override
  Future<void> delete(PresenceEntity presenceEntity) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Stream<List<PresenceEntity>> getPresence(String uid) {
    final CollectionReference presenceCollectionRef = firestore.collection('presences');
    final _presencesStream = presenceCollectionRef.snapshots();

    return _presencesStream.map((querySnap){
      return querySnap.docs.map((docSnap) => PresenceModel.fromSnapshot(docSnap)).toList();
    });
  }

  @override
  Future<bool> isSignIn() async => auth.currentUser?.uid != null;

  @override
  Future<void> signIn(UserEntity userEntity) async {
    auth.signInWithEmailAndPassword(email: userEntity.email!, password: userEntity.password!);
    print(auth.currentUser!.uid);
  }

  @override
  Future<void> signOut() async => auth.signOut();

  @override
  Future<void> signUp(UserEntity userEntity) async {
    //temporary solution: await
    await auth.createUserWithEmailAndPassword(email: userEntity.email!, password: userEntity.password!);
  }

  @override
  Future<void> update(PresenceEntity presenceEntity) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future<void> getCreateCurrentUser(UserEntity userEntity) async {
    final CollectionReference userCollectionRef = firestore.collection('students');
    final uid = await getCurrentUserId();
    print(uid);

    await userCollectionRef.doc(uid).get().then((user){
      //TODO: add user properties
      final newUser = UserModel(
        name: userEntity.name,
        email: userEntity.email,
        password: userEntity.password
      ).toDocument();

      if(!user.exists) {
        userCollectionRef.doc(uid).set(newUser);
      }
      return;
    });
  }

  @override
  Future<String> getCurrentUserId() async => auth.currentUser!.uid;
}