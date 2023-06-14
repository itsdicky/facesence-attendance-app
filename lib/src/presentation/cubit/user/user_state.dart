part of 'user_cubit.dart';

abstract class UserState extends Equatable {
  const UserState();
}

class UserInitial extends UserState {
  @override
  List<Object> get props => [];
}

class UserLoading extends UserState {
  @override
  List<Object?> get props => [];
}

class UserFailure extends UserState {
  final String? message;

  UserFailure({this.message});

  @override
  List<Object?> get props => [];
}

class UserSuccess extends UserState {
  final String? uid;
  final Map<String, dynamic>? userInfo;

  UserSuccess({this.uid ,this.userInfo});

  @override
  List<Object?> get props => [];
}
