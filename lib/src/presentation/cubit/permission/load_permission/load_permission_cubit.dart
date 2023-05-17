import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/entities/permission_entity.dart';
import '../../../../domain/use_case/get_permission_usecase.dart';

part 'load_permission_state.dart';

class LoadPermissionCubit extends Cubit<LoadPermissionState> {
  final GetPermissionUsecase getPermissionUsecase;

  LoadPermissionCubit({required this.getPermissionUsecase}) : super(LoadPermissionInitial());

  Future<void> getCurrentUserPermissions() async {
    emit(LoadPermissionLoading());
    try {
      getPermissionUsecase.call().listen((permission) {
        emit(LoadPermissionLoading());
        emit(LoadPermissionSuccess(presences: permission));
      });
    } on SocketException catch(_) {
      emit(LoadPermissionFailure());
    } catch(_) {
      emit(LoadPermissionFailure());
    }
  }
}
