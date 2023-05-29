part of 'load_presence_cubit.dart';

abstract class LoadPresenceState extends Equatable {
  const LoadPresenceState();
}

class LoadPresenceInitial extends LoadPresenceState {
  @override
  List<Object> get props => [];
}

class LoadPresenceLoading extends LoadPresenceState {
  @override
  List<Object> get props => [];
}

class LoadPresenceFailure extends LoadPresenceState {
  final String? message;

  const LoadPresenceFailure({this.message});

  @override
  List<Object> get props => [];
}

class LoadPresenceSuccess extends LoadPresenceState {
  final List<PresenceEntity> presences;
  final bool isAlreadyPresence;

  const LoadPresenceSuccess({required this.presences, required this.isAlreadyPresence});

  @override
  List<Object> get props => [];
}
