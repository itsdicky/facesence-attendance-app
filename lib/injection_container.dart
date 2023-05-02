import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:sistem_presensi/feature/data/remote/data_sources/firebase_datasource.dart';
import 'package:sistem_presensi/feature/data/remote/data_sources/firebase_datasource_implement.dart';
import 'package:sistem_presensi/feature/data/repositories/firebase_repository_implement.dart';
import 'package:sistem_presensi/feature/domain/repositories/firebase_repository.dart';
import 'package:sistem_presensi/feature/domain/use_case/add_new_presence_usecase.dart';
import 'package:sistem_presensi/feature/domain/use_case/get_create_current_user_usecase.dart';
import 'package:sistem_presensi/feature/domain/use_case/get_current_uid_usecase.dart';
import 'package:sistem_presensi/feature/domain/use_case/get_presence_usecase.dart';
import 'package:sistem_presensi/feature/domain/use_case/is_sign_in_usecase.dart';
import 'package:sistem_presensi/feature/domain/use_case/sign_in_usecase.dart';
import 'package:sistem_presensi/feature/domain/use_case/sign_out_usecase.dart';
import 'package:sistem_presensi/feature/domain/use_case/sign_up_usecase.dart';
import 'package:sistem_presensi/feature/presentation/cubit/auth/auth_cubit.dart';
import 'package:sistem_presensi/feature/presentation/cubit/presence/presence_cubit.dart';
import 'package:sistem_presensi/feature/presentation/cubit/user/user_cubit.dart';

// Class for dependency injection

GetIt sl = GetIt.instance;

Future<void> init() async {

  //cubit
  sl.registerFactory<AuthCubit>(() => AuthCubit(
      getCurrentUidCase: sl.call(),
      isSignInUseCase: sl.call(),
      signOutUsecase: sl.call()
  ));

  sl.registerFactory<UserCubit>(() => UserCubit(
      signUpUseCase: sl.call(),
      signInUseCase: sl.call(),
      getCreateCurrentUseCase: sl.call()
  ));

  sl.registerFactory<PresenceCubit>(() => PresenceCubit(
      addNewPresenceUseCase: sl.call(),
      getPresenceUsecase: sl.call()
  ));
  
  //usecase
  sl.registerLazySingleton<SignUpUseCase>(() => SignUpUseCase(repository: sl.call()));
  sl.registerLazySingleton<SignInUseCase>(() => SignInUseCase(repository: sl.call()));
  sl.registerLazySingleton<IsSignInUseCase>(() => IsSignInUseCase(repository: sl.call()));
  sl.registerLazySingleton<SignOutUsecase>(() => SignOutUsecase(repository: sl.call()));
  sl.registerLazySingleton<GetCreateCurrentUseCase>(() => GetCreateCurrentUseCase(repository: sl.call()));
  sl.registerLazySingleton<AddNewPresenceUseCase>(() => AddNewPresenceUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetCurrentUidUsecase>(() => GetCurrentUidUsecase(repository: sl.call()));
  sl.registerLazySingleton<GetPresenceUsecase>(() => GetPresenceUsecase(repository: sl.call()));

  //repository
  sl.registerLazySingleton<FirebaseRepository>(() => FireBaseRepositoryImplement(dataSource: sl.call()));

  //data source
  sl.registerLazySingleton<FirebaseDataSource>(() => FirebaseDataSourceImplement(auth: sl.call(), firestore: sl.call()));
  
  //external
  final FirebaseAuth auth = await FirebaseAuth.instanceFor(app: Firebase.app());
  final FirebaseFirestore  firestore = await FirebaseFirestore.instance;

  sl.registerLazySingleton<FirebaseAuth>(() => auth);
  sl.registerLazySingleton<FirebaseFirestore>(() => firestore);
}