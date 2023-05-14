import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sistem_presensi/src/domain/entities/presence_entity.dart';
import 'package:sistem_presensi/src/domain/use_case/add_new_presence_usecase.dart';
import 'package:sistem_presensi/src/domain/use_case/get_presence_usecase.dart';
import 'package:sistem_presensi/src/presentation/cubit/presence/presence_state.dart';

class PresenceCubit extends Cubit<PresenceState> {
  final AddNewPresenceUseCase addNewPresenceUseCase;
  final GetPresenceUsecase getPresenceUsecase;
  PresenceCubit({required this.addNewPresenceUseCase, required this.getPresenceUsecase}) : super(PresenceInitial());

  Future<void> addPresence({required PresenceEntity presence}) async {
    emit(PresenceLoading());
    try {
      await addNewPresenceUseCase.call(presence);
      emit(PresenceAdded());
    } on FirebaseException catch(e){
      emit(PresenceFailure(message: e.message));
    } on SocketException catch(e) {
      emit(PresenceFailure(message: e.message));
    } catch(_) {
      emit(PresenceFailure());
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