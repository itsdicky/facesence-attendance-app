import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? userId;
  final String? username;
  final String? email;
  final String? role;
  final Timestamp? createdAt;
  final Map<String, dynamic>? userInfo;
  // final String? uid;
  // final String? status;
  final String? password;

  const UserEntity({
    this.userId,
    this.username,
    this.email,
    this.role,
    this.createdAt,
    this.userInfo,
    // this.uid,
    // this.status,
    this.password,
  });

  @override
  List<Object?> get props => [
    userId,
    username,
    email,
    role,
    createdAt,
    userInfo,
    // uid,
    // status,
    password,
  ];
}