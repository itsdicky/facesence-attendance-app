part of 'schedule_cubit.dart';

abstract class ScheduleState extends Equatable {
  const ScheduleState();
}

class ScheduleInitial extends ScheduleState {
  @override
  List<Object> get props => [];
}

class ScheduleLoaded extends ScheduleState {
  final List schedule;

  ScheduleLoaded({required this.schedule});

  @override
  List<Object> get props => [];
}

class ScheduleLoading extends ScheduleState {
 @override
  List<Object> get props => [];
}

class ScheduleFailure extends ScheduleState {
  final String? message;

  ScheduleFailure({this.message});

  @override
  List<Object> get props => [];
}
