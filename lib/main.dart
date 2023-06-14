import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sistem_presensi/src/presentation/cubit/auth/auth_cubit.dart';
import 'package:sistem_presensi/src/presentation/cubit/auth/auth_state.dart';
import 'package:sistem_presensi/utils/bloc_observer.dart';
import 'package:sistem_presensi/src/presentation/cubit/presence/add_presence/add_presence_cubit.dart';
import 'package:sistem_presensi/src/presentation/cubit/user/user_cubit.dart';
import 'package:sistem_presensi/src/presentation/pages/main_page.dart';
import 'package:sistem_presensi/src/presentation/pages/sign_in_page.dart';
import 'package:sistem_presensi/src/presentation/styles/theme_style.dart';
import 'package:sistem_presensi/routes/on_generate_route.dart';
import 'firebase_options.dart';
import 'injection_container.dart' as di;
import 'src/presentation/cubit/permission/add_permission/add_permission_cubit.dart';
import 'src/presentation/cubit/recognition/recognition_cubit.dart';

late List<CameraDescription> cameras;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  cameras = await availableCameras();
  await di.init();
  Bloc.observer = di.sl<LogObserver>();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(create: (_) => di.sl<AuthCubit>()..appStarted()),
        BlocProvider<UserCubit>(create: (_) => di.sl<UserCubit>()),
        BlocProvider<AddPresenceCubit>(create: (_) => di.sl<AddPresenceCubit>()),
        BlocProvider<AddPermissionCubit>(create: (_) => di.sl<AddPermissionCubit>()),
        BlocProvider<RecognitionCubit>(create: (_) => di.sl<RecognitionCubit>()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeStyle.lightTheme,
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        onGenerateRoute: OnGenerateRoute.route,
        routes: {
          '/': (context) {
            return BlocBuilder<AuthCubit, AuthState>(builder: (context, authState) {
              if (authState is Authenticated) {
                print('Authenticated: from main page');
                return MainPage(uid: authState.uid);
              }
              if (authState is UnAuthenticated) {
                print('UnAuthenticated: from main page');
                return const SignInPage();
              }
              return const Center(child: CircularProgressIndicator(),);
            });
          }
        },
      ),
    );
  }
}