import 'package:equatable/equatable.dart';
import 'package:sistem_presensi/src/data/remote/model/user_model.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

class Authenticated extends AuthState {
  final String uid;
  final UserModel user;

  Authenticated({required this.uid, required this.user});

  //TODO: add uid?
  @override
  List<Object> get props => [];
}

class UnAuthenticated extends AuthState {
  @override
  List<Object> get props => [];
}