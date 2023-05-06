import 'package:flutter/material.dart';
import 'package:sistem_presensi/app_const.dart';
import 'package:sistem_presensi/feature/presentation/pages/sign_in_page.dart';
import 'package:sistem_presensi/feature/presentation/pages/sign_up_page.dart';

// Class for routing

class OnGenerateRoute {
  static Route<dynamic> route(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case PageConst.signInPage: {
        return materialBuilder(widget: const SignInPage());
      }
      case PageConst.signUpPage: {
        return materialBuilder(widget: const SignUpPage());
      }
      case PageConst.addPresencePage: {
        return materialBuilder(widget: const ErrorPage());
      }
      default: {
        return materialBuilder(widget: const ErrorPage());
      }
    }

  }
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('error'),
      ),
      body: const Center(
        child: Text('error'),
      ),
    );
  }
}

MaterialPageRoute materialBuilder({required Widget widget}) {
  return MaterialPageRoute(builder: (_) => widget);
}