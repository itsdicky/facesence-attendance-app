import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sistem_presensi/src/domain/entities/permission_entity.dart';

import '../../../../domain/use_case/add_new_permission_usecase.dart';

part 'add_permission_state.dart';

class AddPermissionCubit extends Cubit<AddPermissionState> {
  final AddNewPermissionUseCase addNewPermissionUseCase;

  AddPermissionCubit({required this.addNewPermissionUseCase}) : super(AddPermissionInitial());

  Future<void> addPermission({required PermissionEntity permission}) async {
    emit(AddPermissionLoading());
    try {
      await addNewPermissionUseCase.call(permission);
      emit(AddPermissionSuccess());
    } on FirebaseException catch(e){
      emit(AddPermissionFailure(message: e.message));
    } on SocketException catch(e) {
      emit(AddPermissionFailure(message: e.message));
    } catch(_) {
      emit(const AddPermissionFailure());
    }
  }
}
