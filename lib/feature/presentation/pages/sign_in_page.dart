import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sistem_presensi/app_const.dart';
import 'package:sistem_presensi/feature/domain/entities/user_entity.dart';
import 'package:sistem_presensi/feature/presentation/cubit/auth/auth_cubit.dart';
import 'package:sistem_presensi/feature/presentation/cubit/auth/auth_state.dart';
import 'package:sistem_presensi/feature/presentation/cubit/user/user_cubit.dart';
import 'package:sistem_presensi/feature/presentation/pages/home_page.dart';
import 'package:sistem_presensi/feature/presentation/styles/widget_style.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldGlobalKey = GlobalKey<ScaffoldState>();

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
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text('Masuk',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 32
            ),
          ),
          const SizedBox(
            height: 80,
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Email', textAlign: TextAlign.left,),
              const SizedBox(height: 8,),
              TextField(
                controller: _emailController,
                decoration: WidgetStyle.textfieldDecoration(hintText: 'contoh@email.com'),
                style: const TextStyle(
                    fontSize: 14
                ),
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
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: WidgetStyle.textfieldDecoration(hintText: 'min. 8 karakter'),
                style: const TextStyle(
                    fontSize: 14
                ),
                maxLength: 16,
              ),
            ],
          ),
          const SizedBox(
            height: 80,
          ),
          TextButton(
            style: WidgetStyle.textButtonStyle(),
            onPressed: submitSignIn,
            child: const Text('Lanjut'),
          ),
          const SizedBox(
            height: 20,
          ),
          OutlinedButton(
            style: WidgetStyle.outlinedButtonStyle(),
            onPressed: toSignUp,
            child: const Text('Daftar'),
          ),
        ],
      ),
    );
  }

  submitSignIn() {
    print(_emailController.text);
    print(_passwordController.text);
    if (_emailController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
      BlocProvider.of<UserCubit>(context).submitSignIn(user: UserEntity(
        email: _emailController.text,
        password: _passwordController.text,
      ));
    }
  }

  void toSignUp() {
    Navigator.pushNamedAndRemoveUntil(context, PageConst.signUpPage, (route) => false);
  }
}