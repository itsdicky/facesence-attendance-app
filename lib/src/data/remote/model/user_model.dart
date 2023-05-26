import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sistem_presensi/src/domain/entities/user_entity.dart';

class UserModel extends UserEntity{
  const UserModel({
    final String? userId,
    final String? username,
    final String? email,
    final String? role,
    final Timestamp? createdAt,
    final Map<String, dynamic>? userInfo,
    // final String? uid,
    // final String? status,
    final String? password,
  }): super(
    userId: userId,
    username: username,
    email: email,
    role: role,
    createdAt: createdAt,
    userInfo: userInfo,
    // uid: uid,
    // status: status,
    password: password,
  );

  factory UserModel.fromSnapshot(DocumentSnapshot snapshot){
    return UserModel(
        userId: snapshot.get('user_id'),
        username: snapshot.get('username'),
        email: snapshot.get('email'),
        role: snapshot.get('role'),
        createdAt: snapshot.get('created_at'),
        userInfo: snapshot.get('user_info'),
        // uid: snapshot.get('uid'),
        // status: snapshot.get('status'),
        password: snapshot.get('password')
    );
  }

  Map<String, dynamic> toDocument(){
    return {
      'user_id': userId,
      'username': username,
      'email': email,
      'role': role,
      'created_at': createdAt,
      'user_info': userInfo,
      // 'uid': uid,
      // 'status': status,
      'password': password,
    };
  }
}