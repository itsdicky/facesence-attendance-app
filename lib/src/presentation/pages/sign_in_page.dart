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
                    return MainPage(uid: authState.uid);
                  } else {
                    return _bodyWidget();
                  }
                }
            );
          }
          if(userState is UserLoading) {
            return const Center(child: CircularProgressIndicator(),);
          }
          return _bodyWidget();
        },
        listener:  (context, userState) {
          if (userState is UserSuccess) {
            BlocProvider.of<AuthCubit>(context).loggedIn();
            _clearTextField();
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
                style: Theme.of(context).textTheme.displayMedium?.copyWith(color: ColorStyle.black),
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
                height: 72,
              ),
              TextButton(
                style: CWidgetStyle.textButtonStyle(),
                onPressed: _submitSignIn,
                child: Text('Lanjut', style: Theme.of(context).textTheme.titleSmall?.copyWith(color: ColorStyle.white),),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Belum memiliki akun?'),
                  const SizedBox(width: 8,),
                  TextButton(
                    onPressed: _toSignUpStudent,
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

  _submitSignIn() async {
    if (_formSignInKey.currentState!.validate()) {
      await BlocProvider.of<UserCubit>(context).submitSignIn(user: UserEntity(
        email: _emailController.text,
        password: _passwordController.text,
      ));
    }
  }

  void _clearTextField() {
    _emailController.clear();
    _passwordController.clear();
  }

  void _toSignUpStudent() {
    Navigator.pushNamedAndRemoveUntil(context, PageConst.signUpPage, (route) => false);
  }
  void _toSignUpTeacher() {
    Navigator.pushNamedAndRemoveUntil(context, PageConst.signUpPage, (route) => false);
  }
}