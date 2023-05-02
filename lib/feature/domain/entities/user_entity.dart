import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  // final String? name;
  final String? email;
  // final String? uid;
  // final String? status;
  final String? password;

  const UserEntity({
    // this.name,
    this.email,
    // this.uid,
    // this.status,
    this.password,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    // name,
    email,
    // uid,
    // status,
    password,
  ];
}