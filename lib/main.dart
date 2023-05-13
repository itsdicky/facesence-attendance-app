import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sistem_presensi/src/presentation/cubit/auth/auth_cubit.dart';
import 'package:sistem_presensi/src/presentation/cubit/auth/auth_state.dart';
import 'package:sistem_presensi/src/presentation/cubit/navbar/navbar_cubit.dart';
import 'package:sistem_presensi/src/presentation/cubit/presence/presence_cubit.dart';
import 'package:sistem_presensi/src/presentation/cubit/user/user_cubit.dart';
import 'package:sistem_presensi/src/presentation/pages/main_page.dart';
import 'package:sistem_presensi/src/presentation/pages/sign_in_page.dart';
import 'package:sistem_presensi/src/presentation/styles/theme_style.dart';
import 'package:sistem_presensi/routes/on_generate_route.dart';
import 'firebase_options.dart';
import 'injection_container.dart' as di;

late List<CameraDescription> cameras;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  cameras = await availableCameras();
  await di.init();
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
        BlocProvider<PresenceCubit>(create: (_) => di.sl<PresenceCubit>()),
        BlocProvider<NavbarCubit>(create: (_) => di.sl<NavbarCubit>())
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
                return MainPage(uid: authState.uid, user: authState.user,);
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