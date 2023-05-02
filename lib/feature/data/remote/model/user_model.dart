import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sistem_presensi/feature/domain/entities/user_entity.dart';

class UserModel extends UserEntity{
  const UserModel({
    // final String? name,
    final String? email,
    // final String? uid,
    // final String? status,
    final String? password,
  }): super(
    // name: name,
    email: email,
    // uid: uid,
    // status: status,
    password: password,
  );

  factory UserModel.fromSnapshot(DocumentSnapshot snapshot){
    return UserModel(
        // name: snapshot.get('name'),
        email: snapshot.get('email'),
        // uid: snapshot.get('uid'),
        // status: snapshot.get('status'),
        password: snapshot.get('password')
    );
  }

  Map<String, dynamic> toDocument(){
    return {
      // 'name': name,
      'email': email,
      // 'uid': uid,
      // 'status': status,
      'password': password,
    };
  }
}