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

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // WidgetStyle _widgetStyle = WidgetStyle();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

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
                return HomePage(uid: authState.uid);
              } else {
                return _bodyWidget();
              }
            });
          }
          return _bodyWidget();
        },
        listener: (context, userState) {
          if (userState is UserSuccess) {
            print(userState);
            BlocProvider.of<AuthCubit>(context).loggedIn();
          }
          if (userState is UserFailure) {
            //TODO: add error message with snackbarError
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('User Failed')));
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
                style: Theme.of(context).textTheme.displayMedium?.copyWith(color: Colors.black),
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
                    decoration: WidgetStyle.textfieldDecoration(hintText: 'min. 6 karakter, max. 14'),
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
                        return 'Invalid password';
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
                height: 50,
              ),
              TextButton(
                style: WidgetStyle.textButtonStyle(),
                onPressed: submitSignUp,
                child: const Text('Lanjut'),
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

  submitSignUp() {
    if (_formSignUpKey.currentState!.validate()) {
      BlocProvider.of<UserCubit>(context).submitSignUp(user: UserEntity(
          name: _usernameController.text,
          email: _emailController.text,
          password: _passwordController.text
      ));
    }
  }
}