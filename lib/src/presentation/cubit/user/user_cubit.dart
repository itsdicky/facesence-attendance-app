import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sistem_presensi/src/domain/entities/user_entity.dart';
import 'package:sistem_presensi/src/domain/use_case/get_create_current_user_usecase.dart';
import 'package:sistem_presensi/src/domain/use_case/sign_in_usecase.dart';
import 'package:sistem_presensi/src/domain/use_case/sign_up_usecase.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final SignUpUseCase signUpUseCase;
  final SignInUseCase signInUseCase;
  final GetCreateCurrentUseCase getCreateCurrentUseCase;

  UserCubit({required this.signUpUseCase, required this.signInUseCase, required this.getCreateCurrentUseCase}) : super(UserInitial());

  Future<void> submitSignIn({required UserEntity user})async{
    emit(UserLoading());
    try {
      await signInUseCase.call(user);
      emit(UserSuccess());
    } on SocketException catch(_){
      emit(UserFailure());
    } catch(_){
      emit(UserFailure());
    }
  }

  Future<void> submitSignUp({required UserEntity user}) async {
    emit(UserLoading());
    try {
      await signUpUseCase.call(user);
      await getCreateCurrentUseCase.call(user);
      emit(UserSuccess());
    } on SocketException catch (_) {
      emit(UserFailure());
    } catch (_) {
      emit(UserFailure());
    }
  }
}
