import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sistem_presensi/constant/page_const.dart';
import 'package:sistem_presensi/main.dart';
import 'package:sistem_presensi/src/presentation/cubit/presence/add_presence/add_presence_cubit.dart';
import 'package:sistem_presensi/src/presentation/cubit/presence/add_presence/add_presence_state.dart';
import 'package:sistem_presensi/src/presentation/widget/common/appbar_widget.dart';

class PresenceCameraPage extends StatefulWidget {
  final CameraDescription camera = cameras[1];

  PresenceCameraPage({super.key});

  @override
  State<PresenceCameraPage> createState() => _PresenceCameraPageState();
}

class _PresenceCameraPageState extends State<PresenceCameraPage> {
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
    return BlocListener<AddPresenceCubit, AddPresenceState>(
      listener: (context, presenceState){
        if (presenceState is AddPresenceSuccess) {
          Navigator.popUntil(context, (route) => route.isFirst);
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Presensi berhasil')));
        }
        if (presenceState is AddPresenceFailure) {
          Navigator.popUntil(context, (route) => route.isFirst);
          final failMessage = presenceState.message;
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Terjadi kesalahan: $failMessage')));
        }
      },
      child: Scaffold(
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

                    final image = await _controller.takePicture();
                    final timestamp = Timestamp.now();

                    if (!mounted) return;

                    await Navigator.pushNamed(context, PageConst.presencePreviewPage, arguments: [image.path, timestamp]);
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