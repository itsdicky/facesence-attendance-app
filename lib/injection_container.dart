import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:sistem_presensi/src/data/remote/data_sources/firebase_datasource.dart';
import 'package:sistem_presensi/src/data/remote/data_sources/firebase_datasource_implement.dart';
import 'package:sistem_presensi/src/data/repositories/firebase_repository_implement.dart';
import 'package:sistem_presensi/src/domain/repositories/firebase_repository.dart';
import 'package:sistem_presensi/src/domain/use_case/add_new_presence_usecase.dart';
import 'package:sistem_presensi/src/domain/use_case/get_create_current_user_usecase.dart';
import 'package:sistem_presensi/src/domain/use_case/get_current_uid_usecase.dart';
import 'package:sistem_presensi/src/domain/use_case/get_presence_usecase.dart';
import 'package:sistem_presensi/src/domain/use_case/get_today_schedule_usecase.dart';
import 'package:sistem_presensi/src/domain/use_case/is_sign_in_usecase.dart';
import 'package:sistem_presensi/src/domain/use_case/sign_in_usecase.dart';
import 'package:sistem_presensi/src/domain/use_case/sign_out_usecase.dart';
import 'package:sistem_presensi/src/domain/use_case/sign_up_usecase.dart';
import 'package:sistem_presensi/src/presentation/cubit/auth/auth_cubit.dart';
import 'package:sistem_presensi/src/presentation/cubit/navbar/navbar_cubit.dart';
import 'package:sistem_presensi/utils/bloc_observer.dart';
import 'package:sistem_presensi/src/presentation/cubit/presence/presence_cubit.dart';
import 'package:sistem_presensi/src/presentation/cubit/schedule/schedule_cubit.dart';
import 'package:sistem_presensi/src/presentation/cubit/user/user_cubit.dart';

import 'src/domain/use_case/get_current_user_usecase.dart';

// Class for dependency injection

GetIt sl = GetIt.instance;

Future<void> init() async {

  //cubit
  sl.registerFactory<AuthCubit>(() => AuthCubit(
      getCurrentUidCase: sl.call(),
      isSignInUseCase: sl.call(),
      signOutUsecase: sl.call(),
      getCurrentUserUsecase: sl.call()
  ));

  sl.registerFactory<UserCubit>(() => UserCubit(
      signUpUseCase: sl.call(),
      signInUseCase: sl.call(),
      getCreateCurrentUseCase: sl.call(),
      getCurrentUserUsecase: sl.call()
  ));

  sl.registerFactory<ScheduleCubit>(() => ScheduleCubit(
      getTodayScheduleUsecase: sl.call()
  ));

  sl.registerFactory<PresenceCubit>(() => PresenceCubit(
      addNewPresenceUseCase: sl.call(),
      getPresenceUsecase: sl.call()
  ));

  sl.registerFactory<NavbarCubit>(() => NavbarCubit());

  sl.registerFactory<LogObserver>(() => LogObserver());
  
  //usecase
  sl.registerLazySingleton<SignUpUseCase>(() => SignUpUseCase(repository: sl.call()));
  sl.registerLazySingleton<SignInUseCase>(() => SignInUseCase(repository: sl.call()));
  sl.registerLazySingleton<IsSignInUseCase>(() => IsSignInUseCase(repository: sl.call()));
  sl.registerLazySingleton<SignOutUsecase>(() => SignOutUsecase(repository: sl.call()));
  sl.registerLazySingleton<GetCreateCurrentUseCase>(() => GetCreateCurrentUseCase(repository: sl.call()));
  sl.registerLazySingleton<AddNewPresenceUseCase>(() => AddNewPresenceUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetCurrentUidUsecase>(() => GetCurrentUidUsecase(repository: sl.call()));
  sl.registerLazySingleton<GetCurrentUserUsecase>(() => GetCurrentUserUsecase(repository: sl.call()));
  sl.registerLazySingleton<GetTodayScheduleUsecase>(() => GetTodayScheduleUsecase(repository: sl.call()));
  sl.registerLazySingleton<GetPresenceUsecase>(() => GetPresenceUsecase(repository: sl.call()));

  //repository
  sl.registerLazySingleton<FirebaseRepository>(() => FireBaseRepositoryImplement(dataSource: sl.call()));

  //data source
  sl.registerLazySingleton<FirebaseDataSource>(() => FirebaseDataSourceImplement(auth: sl.call(), firestore: sl.call(), storage: sl.call()));
  
  //external
  final FirebaseAuth auth = await FirebaseAuth.instanceFor(app: Firebase.app());
  final FirebaseFirestore  firestore = await FirebaseFirestore.instance;
  final FirebaseStorage storage = await FirebaseStorage.instanceFor(app: Firebase.app());

  sl.registerLazySingleton<FirebaseAuth>(() => auth);
  sl.registerLazySingleton<FirebaseFirestore>(() => firestore);
  sl.registerLazySingleton<FirebaseStorage>(() => storage);
}