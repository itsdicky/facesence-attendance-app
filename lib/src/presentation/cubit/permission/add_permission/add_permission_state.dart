part of 'add_permission_cubit.dart';

abstract class AddPermissionState extends Equatable {
  const AddPermissionState();
}

class AddPermissionInitial extends AddPermissionState {
  @override
  List<Object> get props => [];
}

class AddPermissionForm extends AddPermissionState {
  final String category;
  final String desc;

  const AddPermissionForm({required this.category, required this.desc});

  @override
  List<Object> get props => [];
}

class AddPermissionPreview extends AddPermissionState {
  final String category;
  final String desc;
  final File file;

  const AddPermissionPreview({required this.category, required this.desc, required this.file});

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