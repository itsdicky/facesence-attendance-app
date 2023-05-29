import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sistem_presensi/src/domain/use_case/is_already_presence_usecase.dart';

import '../../../../domain/entities/presence_entity.dart';
import '../../../../domain/use_case/delete_all_usecase.dart';
import '../../../../domain/use_case/get_presence_usecase.dart';

part 'load_presence_state.dart';

class LoadPresenceCubit extends Cubit<LoadPresenceState> {
  final IsAlreadyPresenceUseCase isAlreadyPresenceUseCase;
  final GetPresenceUsecase getPresenceUsecase;
  final DeleteAllUseCase deleteAllUseCase;

  LoadPresenceCubit({required this.isAlreadyPresenceUseCase ,required this.getPresenceUsecase, required this.deleteAllUseCase}) : super(LoadPresenceInitial());

  Future<void> getCurrentUserPresences() async {
    emit(LoadPresenceLoading());
    try {
      final isPresence = await isAlreadyPresenceUseCase.call();
      getPresenceUsecase.call().listen((presences) {
        emit(LoadPresenceLoading());
        emit(LoadPresenceSuccess(presences: presences, isAlreadyPresence: isPresence));
      });
    } on SocketException catch(_) {
      emit(LoadPresenceFailure());
    } catch(_) {
      emit(LoadPresenceFailure());
    }
  }

  Future<void> deleteAll(String collectionName) async {
    await deleteAllUseCase.call(collectionName);
  }
}
