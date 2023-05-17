part of 'add_permission_cubit.dart';

abstract class AddPermissionState extends Equatable {
  const AddPermissionState();
}

class AddPermissionInitial extends AddPermissionState {
  @override
  List<Object> get props => [];
}

class AddPermissionLoading extends AddPermissionState {
  @override
  List<Object> get props => [];
}

class AddPermissionSuccess extends AddPermissionState {
  @override
  List<Object> get props => [];
}

class AddPermissionFailure extends AddPermissionState {
  final String? message;

  const AddPermissionFailure({this.message});

  @override
  List<Object> get props => [];
}