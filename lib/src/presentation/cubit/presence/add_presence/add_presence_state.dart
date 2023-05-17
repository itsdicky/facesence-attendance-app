import 'package:equatable/equatable.dart';

abstract class AddPresenceState extends Equatable {
  const AddPresenceState();
}

class AddPresenceInitial extends AddPresenceState {
  @override
  List<Object> get props => [];
}

class AddPresenceLoading extends AddPresenceState {
  @override
  List<Object> get props => [];
}

class AddPresenceSuccess extends AddPresenceState {
  @override
  List<Object> get props => [];
}

class AddPresenceFailure extends AddPresenceState {
  final String? message;

  const AddPresenceFailure({this.message});

  @override
  List<Object> get props => [];
}