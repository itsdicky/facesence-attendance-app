import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/use_case/get_current_uid_usecase.dart';
import '../../../domain/use_case/is_sign_in_usecase.dart';
import '../../../domain/use_case/sign_out_usecase.dart';
import '../../../domain/use_case/get_current_user_usecase.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final GetCurrentUidUsecase getCurrentUidCase;
  final IsSignInUseCase isSignInUseCase;
  final SignOutUsecase signOutUsecase;
  final GetCurrentUserUsecase getCurrentUserUsecase;
  AuthCubit({required this.getCurrentUidCase, required this.isSignInUseCase, required this.signOutUsecase, required this.getCurrentUserUsecase}) : super(AuthInitial());

  Future<void> appStarted() async {
    try {
      final isSignIn = await isSignInUseCase.call();
      if(isSignIn) {
        final uid = await getCurrentUidCase.call();
        emit(Authenticated(uid: uid));
      } else {
        emit(UnAuthenticated());
      }
    } on SocketException catch(_) {
      emit(UnAuthenticated());
    }
  }

  Future<void> loggedIn() async {
    try {
      final uid = await getCurrentUidCase.call();
      emit(Authenticated(uid: uid));
    } on SocketException catch(_) {
      emit(UnAuthenticated());
    }
  }

  Future<void> loggedOut() async {
    try {
      await signOutUsecase.call();
      emit(UnAuthenticated());
    } on SocketException catch(_) {
      emit(UnAuthenticated());
    }
  }
}