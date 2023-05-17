import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/entities/presence_entity.dart';
import '../../../../domain/use_case/get_presence_usecase.dart';

part 'load_presence_state.dart';

class LoadPresenceCubit extends Cubit<LoadPresenceState> {
  final GetPresenceUsecase getPresenceUsecase;

  LoadPresenceCubit({required this.getPresenceUsecase}) : super(LoadPresenceInitial());

  Future<void> getCurrentUserPresences() async {
    emit(LoadPresenceLoading());
    try {
      getPresenceUsecase.call().listen((presences) {
        emit(LoadPresenceLoading());
        emit(LoadPresenceSuccess(presences: presences));
      });
    } on SocketException catch(_) {
      emit(LoadPresenceFailure());
    } catch(_) {
      emit(LoadPresenceFailure());
    }
  }
}
