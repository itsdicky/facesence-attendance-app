import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sistem_presensi/src/domain/entities/user_entity.dart';

class UserModel extends UserEntity{
  const UserModel({
    final String? userId,
    final String? username,
    final String? email,
    final String? role,
    final String? grade,
    final Timestamp? createdAt,
    final Map<String, dynamic>? userInfo,
    final String? password,
  }): super(
    userId: userId,
    email: email,
    role: role,
    grade: grade,
    createdAt: createdAt,
    userInfo: userInfo,
    password: password,
  );

  factory UserModel.fromSnapshot(DocumentSnapshot snapshot){
    return UserModel(
        userId: snapshot.get('user_id'),
        email: snapshot.get('email'),
        role: snapshot.get('role'),
        grade: snapshot.get('classroom'),
        createdAt: snapshot.get('created_at'),
        userInfo: snapshot.get('user_info'),
        password: snapshot.get('password')
    );
  }

  Map<String, dynamic> toDocument(){
    return {
      'user_id': userId,
      'email': email,
      'role': role,
      'classroom': grade,
      'created_at': createdAt,
      'user_info': userInfo,
      'password': password,
    };
  }
}