import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sistem_presensi/src/presentation/widget/common/appbar_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constant/page_const.dart';
import '../../../main.dart';
import '../cubit/auth/auth_cubit.dart';
import '../cubit/auth/auth_state.dart';
import '../cubit/recognition/recognition_cubit.dart';
import 'main_page.dart';

class CameraSignUpPage extends StatefulWidget {
  final CameraDescription camera = cameras[1];
  final String uid;

  CameraSignUpPage({super.key, required this.uid});

  @override
  State<CameraSignUpPage> createState() => _CameraSignUpPageState();
}

class _CameraSignUpPageState extends State<CameraSignUpPage> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    _controller = CameraController(widget.camera, ResolutionPreset.medium);
    _initializeControllerFuture = _controller.initialize();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<RecognitionCubit, RecognitionState>(
        listener: (context, recognitionState) {
          if (recognitionState is RecognitionSuccess) {
            BlocProvider.of<AuthCubit>(context).loggedIn();
            Navigator.pushReplacementNamed(context, PageConst.signInPage);
          }
          if (recognitionState is RecognitionFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(recognitionState.message ?? 'User Failed')));
          }
        },
        child: BlocBuilder<AuthCubit, AuthState>(builder: (context, authState){
          if (authState is Authenticated) {
            return MainPage(uid: authState.uid);
          } else {
            return FutureBuilder(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return _cameraWidget();
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            );
          }
        }),
      ),
    );
  }

  Widget _cameraWidget() {
    return Column(
      children: [
        const PreferredSize(preferredSize: Size.fromHeight(kToolbarHeight), child: CTitleAppBarLight(title: 'Daftarkan Wajah')),
        Stack(children: [
          CameraPreview(_controller),
          Positioned.fill(
            bottom: 12,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.0),
                  color: Colors.black38,
                ),
                child: Text('Ambil swafoto, wajah harus terlihat jelas', style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Colors.white),),
              ),
            ),
          ),
        ],),
        // const SizedBox(height: 42,),
        Expanded(
          child: SizedBox(
            height: 72,
            width: 72,
            child: FittedBox(
              child: FloatingActionButton(
                elevation: 0,
                onPressed: () async {
                  try {
                    await _initializeControllerFuture;

                    XFile cameraImage = await _controller.takePicture();
                    File image = File(cameraImage.path);
                    BlocProvider.of<RecognitionCubit>(context).storeFaceArray(widget.uid, image);

                    if (!mounted) return;
                    // BlocProvider.of<AddPresenceCubit>(context).capturePresenceSnapshot(image: image);
                    // Navigator.pushNamed(context, PageConst.presencePreviewPage);
                  } catch(e) {
                    print(e);
                  }
                },
                child: const Icon(Icons.camera_alt),
              ),
            ),
          ),
        ),
      ],
    );
  }
}