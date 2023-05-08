import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:sistem_presensi/app_const.dart';

class CCameraWidget extends StatefulWidget {
  final CameraDescription camera;

  const CCameraWidget({super.key, required this.camera});

  @override
  State<CCameraWidget> createState() => _CCameraWidgetState();
}

class _CCameraWidgetState extends State<CCameraWidget> {
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
                child: Text('Ambil foto dokumen surat izin', style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Colors.white),),
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

                    final image = await _controller.takePicture();

                    if (!mounted) return;

                    await Navigator.pushNamed(context, PageConst.pictureDisplayPage, arguments: image.path);
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