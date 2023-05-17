import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'calendar_state.dart';

class CalendarCubit extends Cubit<DateTime> {
  CalendarCubit() : super(DateTime.now());

  Future<void> changeDate(DateTime dateTime) async {
    emit(dateTime);
  }
}
