import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? userId;
  // final String? username;
  final String? email;
  final String? role;
  final String? grade;
  final Timestamp? createdAt;
  final Map<String, dynamic>? userInfo;
  final String? password;

  const UserEntity({
    this.userId,
    // this.username,
    this.email,
    this.role,
    this.grade,
    this.createdAt,
    this.userInfo,
    this.password,
  });

  @override
  List<Object?> get props => [
    userId,
    // username,
    email,
    role,
    grade,
    createdAt,
    userInfo,
    // uid,
    // status,
    password,
  ];
}