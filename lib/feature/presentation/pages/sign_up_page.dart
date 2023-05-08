import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sistem_presensi/app_const.dart';
import 'package:sistem_presensi/feature/domain/entities/user_entity.dart';
import 'package:sistem_presensi/feature/presentation/cubit/auth/auth_cubit.dart';
import 'package:sistem_presensi/feature/presentation/cubit/auth/auth_state.dart';
import 'package:sistem_presensi/feature/presentation/cubit/user/user_cubit.dart';
import 'package:sistem_presensi/feature/presentation/pages/main_page.dart';
import 'package:sistem_presensi/feature/presentation/styles/widget_style.dart';

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

  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

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
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text('Daftar',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 32
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Username'),
              const SizedBox(height: 8,),
              TextField(
                controller: _usernameController,
                decoration: WidgetStyle.textfieldDecoration(hintText: 'username'),
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
              TextField(
                controller: _emailController,
                decoration: WidgetStyle.textfieldDecoration(hintText: 'contoh@email.com'),
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
          OutlinedButton(
            style: WidgetStyle.outlinedButtonStyle(),
            onPressed: () => Navigator.pushNamedAndRemoveUntil(context, PageConst.signInPage, (route) => false),
            child: const Text('Masuk'),
          ),
        ],
      ),
    );
  }

  submitSignUp() {
    if (_usernameController.text.isNotEmpty && _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
      BlocProvider.of<UserCubit>(context).submitSignUp(user: UserEntity(
        name: _usernameController.text,
        email: _emailController.text,
        password: _passwordController.text
      ));
    }
  }
}