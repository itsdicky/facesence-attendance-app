import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sistem_presensi/feature/domain/entities/presence_entity.dart';
import 'package:sistem_presensi/feature/domain/use_case/add_new_presence_usecase.dart';
import 'package:sistem_presensi/feature/domain/use_case/get_presence_usecase.dart';
import 'package:sistem_presensi/feature/presentation/cubit/presence/presence_state.dart';

class PresenceCubit extends Cubit<PresenceState> {
  final AddNewPresenceUseCase addNewPresenceUseCase;
  final GetPresenceUsecase getPresenceUsecase;
  PresenceCubit({required this.addNewPresenceUseCase, required this.getPresenceUsecase}) : super(PresenceInitial());

  Future<void> addPresence({required PresenceEntity presence}) async {
    try {
      await addNewPresenceUseCase.call(presence);
    } on SocketException catch(_) {

    } catch(_) {

    }
  }
  Future<void> getPresence({required String uid}) async {
    emit(PresenceLoading());
    try {
      getPresenceUsecase.call(uid).listen((presences) {
        emit(PresenceLoaded(presences: presences));
      });
    } on SocketException catch(_) {
      emit(PresenceFailure());
    } catch(_) {
      emit(PresenceFailure());
    }
  }
}