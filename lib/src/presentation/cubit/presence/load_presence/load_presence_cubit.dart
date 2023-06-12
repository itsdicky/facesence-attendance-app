import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sistem_presensi/src/domain/use_case/is_already_presence_usecase.dart';

import '../../../../domain/entities/presence_entity.dart';
import '../../../../domain/use_case/get_presence_usecase.dart';

part 'load_presence_state.dart';

class LoadPresenceCubit extends Cubit<LoadPresenceState> {
  final IsAlreadyPresenceUseCase isAlreadyPresenceUseCase;
  final GetPresenceUsecase getPresenceUsecase;

  LoadPresenceCubit({required this.isAlreadyPresenceUseCase ,required this.getPresenceUsecase}) : super(LoadPresenceInitial());

  Future<void> getCurrentUserPresences() async {
    emit(LoadPresenceLoading());
    try {
      isAlreadyPresenceUseCase.call().listen((event) {print(event);});
      getPresenceUsecase.call().listen((presences) {
        emit(LoadPresenceLoading());
        isAlreadyPresenceUseCase.call().listen((isPresence) {
          emit(LoadPresenceSuccess(presences: presences, isAlreadyPresence: isPresence));
        });
      });
    } on SocketException catch(_) {
      emit(LoadPresenceFailure());
    } catch(_) {
      emit(LoadPresenceFailure());
    }
  }
}
