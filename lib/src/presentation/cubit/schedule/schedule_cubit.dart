import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sistem_presensi/src/domain/use_case/get_today_schedule_usecase.dart';

part 'schedule_state.dart';

class ScheduleCubit extends Cubit<ScheduleState> {
  final GetTodayScheduleUsecase getTodayScheduleUsecase;

  ScheduleCubit({required this.getTodayScheduleUsecase}) : super(ScheduleInitial());

  Future<void> getTodaySchedule() async {
    emit(ScheduleLoading());
    try {
      List schedule = await getTodayScheduleUsecase.call();
      emit(ScheduleLoaded(schedule: schedule));
    } on FirebaseException catch(e) {
      emit(ScheduleFailure(message: e.message));
    } on SocketException catch (e) {
      emit(ScheduleFailure(message: e.message));
    } catch (_) {
      emit(ScheduleFailure());
    }
  }
}
