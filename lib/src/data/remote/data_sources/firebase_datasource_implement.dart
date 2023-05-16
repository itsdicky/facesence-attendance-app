import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:sistem_presensi/src/data/remote/data_sources/firebase_datasource.dart';
import 'package:sistem_presensi/src/data/remote/model/presence_model.dart';
import 'package:sistem_presensi/src/data/remote/model/user_model.dart';
import 'package:sistem_presensi/src/domain/entities/presence_entity.dart';
import 'package:sistem_presensi/src/domain/entities/user_entity.dart';

class FirebaseDataSourceImplement extends FirebaseDataSource {

  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  final FirebaseStorage storage;

  FirebaseDataSourceImplement({required this.auth, required this.firestore, required this.storage});

  @override
  Future<String?> addNewPresence(PresenceEntity presenceEntity) async {
    final storageRef = storage.ref().child('images');

    final uid = await getCurrentUserId();
    final CollectionReference presenceCollectionRef = firestore.collection('users').doc(uid).collection('presences');
    // final presenceId = presenceCollectionRef.doc(presenceEntity.uid).id;
    final presenceId = presenceCollectionRef.doc().id;


    await presenceCollectionRef.doc(presenceId).get().then((presence){

      final imageRef = storageRef.child('$presenceId.jpg');

      final newPresence = PresenceModel(
        presenceId: presenceId,
        isPresence: presenceEntity.isPresence,
        time: presenceEntity.time,
        imageURL: imageRef.fullPath,
      ).toDocument();

      if(!presence.exists) {
        presenceCollectionRef.doc(presenceId).set(newPresence);
        imageRef.putFile(presenceEntity.imageFile!);
        // incrementTotalPresence(uid);
      }
    });
    return uid;
  }

  @override
  Future<void> delete(PresenceEntity presenceEntity) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Stream<List<PresenceEntity>> getPresence(String uid) {
    final uid = getCurrentUserId();
    
    final CollectionReference presenceCollectionRef = firestore.collection('users').doc(uid as String?).collection('presences');
    final _presencesStream = presenceCollectionRef.snapshots();

    return _presencesStream.map((querySnap){
      return querySnap.docs.map((docSnap) => PresenceModel.fromSnapshot(docSnap)).toList();
    });
  }

  @override
  Future<bool> isSignIn() async => auth.currentUser?.uid != null;

  @override
  Future<void> signIn(UserEntity userEntity) async {
    await auth.signInWithEmailAndPassword(email: userEntity.email!, password: userEntity.password!);
    print(auth.currentUser!.uid);
  }

  @override
  Future<void> signOut() async => auth.signOut();

  @override
  Future<void> signUp(UserEntity userEntity) async {
    await auth.createUserWithEmailAndPassword(email: userEntity.email!, password: userEntity.password!)
        .then((value) => value.user?.updateDisplayName('TestUser'));
  }

  @override
  Future<void> update(PresenceEntity presenceEntity) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future<void> getCreateCurrentUser(UserEntity userEntity) async {
    final CollectionReference userCollectionRef = firestore.collection('users');
    final uid = await getCurrentUserId();
    print(uid);

    await userCollectionRef.doc(uid).get().then((user){
      Timestamp createdDateTime = Timestamp.now();

      final newUser = UserModel(
          username: userEntity.username,
        email: userEntity.email,
        role: userEntity.role,
        createdAt: createdDateTime,
        userInfo: userEntity.userInfo,
        password: userEntity.password
      ).toDocument();

      if(!user.exists) {
        userCollectionRef.doc(uid).set(newUser);
      }
      return;
    });
  }

  @override
  Future<UserEntity> getCurrentUser() async {
    final CollectionReference userCollectionRef = firestore.collection('users');
    final uid = await getCurrentUserId();
    late UserModel currentUser;

    await userCollectionRef.doc(uid).get().then((user){
      currentUser = UserModel.fromSnapshot(user);
    });

    return currentUser;
  }

  @override
  Future<String> getCurrentUserId() async => auth.currentUser!.uid;

  @override
  Future<List> getTodaySchedule() async {
    final CollectionReference scheduleCollectionRef = firestore.collection('schedules');
    late List todaySchedule;

    await scheduleCollectionRef.where('day', isEqualTo: 'monday').get().then((value) {
      Map map = value.docs.first.get('class');
      todaySchedule = map['XI Science 2'];
    });

    return todaySchedule;
  }

  @override
  Future<void> incrementTotalPresence(String uid) async {
    final UserEntity user  = await getCurrentUser();
    final DocumentReference userRef = firestore.collection('users').doc(uid);

    final userInfo = user.userInfo!;
    userInfo['total_presence'] = userInfo['total_presence'] + 1;

    await userRef.update({
      'user_info': userInfo
    }).then(
            (value) => print("DocumentSnapshot successfully updated!"),
        onError: (e) => print("Error updating document $e"));
  }
}