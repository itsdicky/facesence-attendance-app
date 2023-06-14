import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sistem_presensi/src/domain/entities/user_entity.dart';
import 'package:sistem_presensi/src/domain/use_case/get_create_current_user_usecase.dart';
import 'package:sistem_presensi/src/domain/use_case/sign_in_usecase.dart';
import 'package:sistem_presensi/src/domain/use_case/sign_up_usecase.dart';

import '../../../domain/use_case/get_current_user_usecase.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final SignUpUseCase signUpUseCase;
  final SignInUseCase signInUseCase;
  final GetCreateCurrentUseCase getCreateCurrentUseCase;
  final GetCurrentUserUsecase getCurrentUserUsecase;

  UserCubit({required this.signUpUseCase, required this.signInUseCase, required this.getCreateCurrentUseCase, required this.getCurrentUserUsecase}) : super(UserInitial());

  Future<void> submitSignIn({required UserEntity user})async{
    emit(UserLoading());
    try {
      await signInUseCase.call(user);
      emit(UserSuccess());
    } on FirebaseAuthException catch(e){
      emit(UserFailure(message: e.message));
    } on SocketException catch(e){
      emit(UserFailure(message: e.message));
    } catch(_){
      emit(UserFailure());
    }
  }

  Future<void> submitSignUp({required UserEntity user}) async {
    emit(UserLoading());
    try {
      final uid = await signUpUseCase.call(user);
      await getCreateCurrentUseCase.call(user);
      emit(UserSuccess(uid: uid));
    } on FirebaseAuthException catch (e) {
      emit(UserFailure(message: e.message));
    } on SocketException catch (e) {
      emit(UserFailure(message: e.message));
    } catch (_) {
      emit(UserFailure());
    }
  }

  Future<void> getUserInfo() async {
    emit(UserLoading());
    try {
      final user = await getCurrentUserUsecase.call();
      print(user);
      emit(UserSuccess(userInfo: user.userInfo));
    } on FirebaseAuthException catch (e) {
      emit(UserFailure(message: e.message));
    } on SocketException catch (e) {
      emit(UserFailure(message: e.message));
    } catch (_) {
      emit(UserFailure());
    }
  }
}
