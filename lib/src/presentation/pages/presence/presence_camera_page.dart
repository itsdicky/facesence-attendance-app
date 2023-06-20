
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sistem_presensi/constant/page_const.dart';
import 'package:sistem_presensi/main.dart';
import 'package:sistem_presensi/src/presentation/cubit/presence/add_presence/add_presence_cubit.dart';
import 'package:sistem_presensi/src/presentation/widget/common/appbar_widget.dart';
import 'dart:async';

class PresenceCameraPage extends StatefulWidget {
  final CameraDescription camera = cameras[1];

  PresenceCameraPage({super.key});

  @override
  State<PresenceCameraPage> createState() => _PresenceCameraPageState();
}

class _PresenceCameraPageState extends State<PresenceCameraPage> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  late Future<XFile> result;
  // late bool streamImage;

  @override
  void initState() {
    _controller = CameraController(widget.camera, ResolutionPreset.medium);
    _initializeControllerFuture = _controller.initialize();
    // streamImage = false;
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
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CTitleAppBarLight(title: 'Foto Presensi',),
      ),
      body: FutureBuilder(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return _cameraWidget();
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget _cameraWidget() {
    return Column(
      children: [
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

                    // if (streamImage == false) {
                    //   _controller.startImageStream((image) {
                    //     var faces = faceDetection.processFromCameraImage(image);
                    //     faces.then((value) => print('List of Faces: $value'));
                    //   });
                    //   setState(() {
                    //     streamImage = true;
                    //   });
                    // } else {
                    //   _controller.stopImageStream();
                    //   setState(() {
                    //     streamImage = false;
                    //   });
                    // }

                    // final byteData = await rootBundle.load('assets/images/img_self_1.jpg');
                    //
                    // final file = File('${(await pp.getTemporaryDirectory()).path}/images/img_self_1.jpg');
                    // await file.create(recursive: true);
                    // await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

                    // final faceSampleArray = await ml.getFaceArray(file);

                    final cameraImage = _controller.takePicture();
                    setState(() {
                      result = cameraImage;
                    });

                    if (!mounted) return;

                    BlocProvider.of<AddPresenceCubit>(context).capturePresenceSnapshot(image: cameraImage);
                    Navigator.pushNamed(context, PageConst.presencePreviewPage);
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

// class Sky extends CustomPainter {
//   final Rect _rect;
//   Sky(this._rect);
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     canvas.drawRect(
//       _rect,
//       Paint()..color = Color(0xFF0099FF),
//     );
//   }
//
//   @override
//   bool shouldRepaint(Sky oldDelegate) {
//     return false;
//   }
// }