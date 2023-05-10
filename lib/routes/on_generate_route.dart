import 'package:flutter/material.dart';
import 'package:sistem_presensi/constant/page_const.dart';
import 'package:sistem_presensi/src/presentation/pages/permission/camera_page.dart';
import 'package:sistem_presensi/src/presentation/pages/notification_page.dart';
import 'package:sistem_presensi/src/presentation/pages/permission/permission_form_page.dart';
import 'package:sistem_presensi/src/presentation/pages/permission/permission_preview.dart';
import 'package:sistem_presensi/src/presentation/pages/permission/picture_display_page.dart';
import 'package:sistem_presensi/src/presentation/pages/sign_in_page.dart';
import 'package:sistem_presensi/src/presentation/pages/sign_up_page.dart';

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
      case PageConst.askPermissionPage: {
        return materialBuilder(widget: const PermissionForm());
      }
      case PageConst.cameraPage: {
        return materialBuilder(widget: const CameraPage());
      }
      case PageConst.pictureDisplayPage: {
        return materialBuilder(widget: PictureDisplayPage(imagePath: args as String));
      }
      case PageConst.permissionPreviewPage: {
        return materialBuilder(widget: PermissionPreviewPage(imagePath: args as String));
      }
      case PageConst.notificationPage: {
        return materialBuilder(widget: const NotificationPage());
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