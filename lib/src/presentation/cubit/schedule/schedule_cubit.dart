import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sistem_presensi/src/domain/use_case/get_today_schedule_usecase.dart';

part 'schedule_state.dart';

class ScheduleCubit extends Cubit<ScheduleState> {
  final GetTodayScheduleUsecase getTodayScheduleUsecase;

  ScheduleCubit({required this.getTodayScheduleUsecase}) : super(ScheduleInitial());

  Future<void> getTodaySchedule() async {
    List schedule = await getTodayScheduleUsecase.call();
    emit(ScheduleLoaded(schedule: schedule));
  }
}
