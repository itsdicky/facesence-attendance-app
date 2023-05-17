part of 'load_permission_cubit.dart';

abstract class LoadPermissionState extends Equatable {
  const LoadPermissionState();
}

class LoadPermissionInitial extends LoadPermissionState {
  @override
  List<Object> get props => [];
}

class LoadPermissionLoading extends LoadPermissionState {
  @override
  List<Object> get props => [];
}

class LoadPermissionFailure extends LoadPermissionState {
  final String? message;

  const LoadPermissionFailure({this.message});

  @override
  List<Object> get props => [];
}

class LoadPermissionSuccess extends LoadPermissionState {
  final List<PermissionEntity> presences;

  const LoadPermissionSuccess({required this.presences});

  @override
  List<Object> get props => [];
}