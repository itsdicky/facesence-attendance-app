import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
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

  Future<void> capturePermissionPreview({required String category, required String desc, required Future<XFile> xfile}) async {
    emit(AddPermissionLoading());
    final file = await xfile;
    emit(AddPermissionPreview(category: category, desc: desc, file: File(file.path)));
  }

  // Future<void> getPermissionPreview({required }) async {
  //   emit(AddPermissionLoading());
  // }
}
