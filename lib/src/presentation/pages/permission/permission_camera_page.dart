import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sistem_presensi/constant/page_const.dart';
import 'package:sistem_presensi/src/presentation/cubit/permission/add_permission/add_permission_cubit.dart';
import 'package:sistem_presensi/src/presentation/widget/common/appbar_widget.dart';
import 'package:sistem_presensi/main.dart';

class PermissionCameraPage extends StatefulWidget {
  final String category;
  final String description;
  final CameraDescription camera = cameras.first;

  PermissionCameraPage({super.key, required this.category, required this.description});

  @override
  State<PermissionCameraPage> createState() => _PermissionCameraPageState();
}

class _PermissionCameraPageState extends State<PermissionCameraPage> {
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
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CTitleAppBarLight(title: 'Foto Dokumen',),
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

                    final image = _controller.takePicture();

                    if (!mounted) return;

                    BlocProvider.of<AddPermissionCubit>(context).capturePermissionPreview(category: widget.category, desc: widget.description, xfile: image);
                    await Navigator.pushNamed(context, PageConst.pictureDisplayPage);
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