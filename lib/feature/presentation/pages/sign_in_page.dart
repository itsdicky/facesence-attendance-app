import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sistem_presensi/app_const.dart';
import 'package:sistem_presensi/feature/domain/entities/user_entity.dart';
import 'package:sistem_presensi/feature/presentation/cubit/auth/auth_cubit.dart';
import 'package:sistem_presensi/feature/presentation/cubit/auth/auth_state.dart';
import 'package:sistem_presensi/feature/presentation/cubit/user/user_cubit.dart';
import 'package:sistem_presensi/feature/presentation/pages/main_page.dart';
import 'package:sistem_presensi/feature/presentation/styles/widget_style.dart';
import 'package:sistem_presensi/utils/scroll_behavior.dart';
import 'package:sistem_presensi/utils/validation.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldGlobalKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formSignInKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldGlobalKey,
      body: BlocConsumer<UserCubit, UserState>(
        builder: (context, userState){
          if(userState is UserSuccess) {
            return BlocBuilder<AuthCubit, AuthState>(
                builder: (context, authState) {
                  if (authState is Authenticated) {
                    return HomePage(uid: authState.uid);
                  } else {
                    return _bodyWidget();
                  }
                }
            );
          }
          return _bodyWidget();
        },
        listener:  (context, userState) {
          if (userState is UserSuccess) {
            BlocProvider.of<AuthCubit>(context).loggedIn();
          }
          if (userState is UserFailure) {
            //TODO: add message login error
            print('User Failed');
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('User Failed')));
          }
        },
      ),
    );
  }

  _bodyWidget() {
    return Form(
      key: _formSignInKey,
      child: Container(
        padding: const EdgeInsets.all(16),
        child: ScrollConfiguration(
          behavior: NoGlowScrollBehavior(),
          child: ListView(
            children: [
              const SizedBox(
                height: 64,
              ),
              Text('Masuk',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(color: Colors.black),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 92,
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Email', textAlign: TextAlign.left,),
                  const SizedBox(height: 8,),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Masukan email';
                      }
                      if (!value.isValidEmail) {
                        return 'Email tidak valid';
                      }
                      return null;
                    },
                    decoration: WidgetStyle.textfieldDecoration(hintText: 'contoh@email.com'),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),

              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Password'),
                  const SizedBox(height: 8,),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Masukan password';
                      }
                      if (!value.isValidPassword) {
                        return 'Masukan minimal 8 karakter';
                      }
                      return null;
                    },
                    decoration: WidgetStyle.textfieldDecoration(hintText: 'min. 8 karakter'),
                    style: Theme.of(context).textTheme.bodyMedium,
                    maxLength: 16,
                  ),
                ],
              ),
              const SizedBox(
                height: 72,
              ),
              TextButton(
                style: WidgetStyle.textButtonStyle(),
                onPressed: submitSignIn,
                child: const Text('Lanjut'),
              ),
              const SizedBox(
                height: 20,
              ),
              // OutlinedButton(
              //   style: WidgetStyle.outlinedButtonStyle(),
              //   onPressed: toSignUpStudent,
              //   child: const Text('Daftar sebagai siswa'),
              // ),
              // const SizedBox(
              //   height: 20,
              // ),
              // OutlinedButton(
              //   style: WidgetStyle.outlinedButtonStyle(),
              //   onPressed: toSignUpTeacher,
              //   child: const Text('Daftar sebagai guru'),
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Belum memiliki akun?'),
                  const SizedBox(width: 8,),
                  TextButton(
                    onPressed: toSignUpStudent,
                    child: const Text(
                      'Daftar',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void submitSignIn() {
    if (_formSignInKey.currentState!.validate()) {
      BlocProvider.of<UserCubit>(context).submitSignIn(user: UserEntity(
        email: _emailController.text,
        password: _passwordController.text,
      ));
    }
  }

  void toSignUpStudent() {
    Navigator.pushNamedAndRemoveUntil(context, PageConst.signUpPage, (route) => false);
  }
  void toSignUpTeacher() {
    Navigator.pushNamedAndRemoveUntil(context, PageConst.signUpPage, (route) => false);
  }
}