import 'package:equatable/equatable.dart';
import 'package:sistem_presensi/src/domain/entities/presence_entity.dart';

abstract class PresenceState extends Equatable {
  const PresenceState();
}

class PresenceInitial extends PresenceState {
  @override
  List<Object> get props => [];
}

class PresenceLoading extends PresenceState {
  @override
  List<Object> get props => [];
}

class PresenceAdded extends PresenceState {
  @override
  List<Object> get props => [];
}

class PresenceFailure extends PresenceState {
  final String? message;

  PresenceFailure({this.message});

  @override
  List<Object> get props => [];
}

class PresenceLoaded extends PresenceState {
  final List<PresenceEntity> presences;
  PresenceLoaded({required this.presences});
  @override
  List<Object> get props => [];
}