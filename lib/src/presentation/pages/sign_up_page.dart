import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sistem_presensi/constant/page_const.dart';
import 'package:sistem_presensi/src/domain/entities/user_entity.dart';
import 'package:sistem_presensi/src/presentation/cubit/auth/auth_cubit.dart';
import 'package:sistem_presensi/src/presentation/cubit/auth/auth_state.dart';
import 'package:sistem_presensi/src/presentation/cubit/user/user_cubit.dart';
import 'package:sistem_presensi/src/presentation/pages/main_page.dart';
import 'package:sistem_presensi/src/presentation/styles/color_style.dart';
import 'package:sistem_presensi/src/presentation/styles/widget_style.dart';
import 'package:sistem_presensi/utils/scroll_behavior.dart';
import 'package:sistem_presensi/utils/validation.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // WidgetStyle _widgetStyle = WidgetStyle();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formSignUpKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      body: BlocConsumer<UserCubit, UserState>(
        builder: (context, userState){
          if(userState is UserSuccess) {
            return BlocBuilder<AuthCubit, AuthState>(builder: (context, authState){
              if (authState is Authenticated) {
                return MainPage(uid: authState.uid);
              } else {
                return _bodyWidget();
              }
            });
          }
          if(userState is UserLoading) {
            return const Center(child: CircularProgressIndicator(),);
          }
          return _bodyWidget();
        },
        listener: (context, userState) {
          if (userState is UserSuccess) {
            print(userState);
            BlocProvider.of<AuthCubit>(context).loggedIn();
            Navigator.pushReplacementNamed(context, PageConst.signInPage);
          }
          if (userState is UserFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(userState.message ?? 'User Failed')));
          }
        },
      ),
    );
  }

  _bodyWidget() {
    return Form(
      key: _formSignUpKey,
      child: Container(
        padding: const EdgeInsets.all(16),
        child: ScrollConfiguration(
          behavior: NoGlowScrollBehavior(),
          child: ListView(
            children: [
              const SizedBox(
                height: 64,
              ),
              Text('Daftar',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(color: ColorStyle.black),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 50,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Username'),
                  const SizedBox(height: 8,),
                  TextFormField(
                    controller: _usernameController,
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Masukan username';
                      }
                      if (!value.isValidUsername) {
                        return 'Masukan minimal 6 karakter';
                      }
                      return null;
                    },
                    decoration: CWidgetStyle.textfieldDecoration(hintText: 'min. 6 karakter, max. 14'),
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
                  const Text('Email'),
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
                    decoration: CWidgetStyle.textfieldDecoration(hintText: 'contoh@email.com'),
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
                    decoration: CWidgetStyle.textfieldDecoration(hintText: 'min. 8 karakter'),
                    style: Theme.of(context).textTheme.bodyMedium,
                    maxLength: 16,
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              TextButton(
                style: CWidgetStyle.textButtonStyle(),
                onPressed: submitSignUp,
                child: Text('Lanjut', style: Theme.of(context).textTheme.titleSmall?.copyWith(color: ColorStyle.white),),
              ),
              const SizedBox(
                height: 20,
              ),
              // OutlinedButton(
              //   style: WidgetStyle.outlinedButtonStyle(),
              //   onPressed: () => Navigator.pushNamedAndRemoveUntil(context, PageConst.signInPage, (route) => false),
              //   child: const Text('Daftar sebagai Guru'),
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Sudah memiliki akun?'),
                  const SizedBox(width: 8,),
                  TextButton(
                    onPressed: () => Navigator.pushNamedAndRemoveUntil(context, PageConst.signInPage, (route) => false),
                    child: const Text(
                      'Masuk',
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

  submitSignUp() async {
    if (_formSignUpKey.currentState!.validate()) {
      await BlocProvider.of<UserCubit>(context).submitSignUp(user: UserEntity(
          username: _usernameController.text,
          email: _emailController.text,
          role: 'student',
          userInfo: const {
            'name': 'NameData',
            'student_number': '123456',
            'classroom': 'StudentGrade'
          },
          password: _passwordController.text
      ));
    }
  }
}