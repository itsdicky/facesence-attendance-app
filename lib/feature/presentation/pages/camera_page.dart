import 'package:flutter/material.dart';
import 'package:sistem_presensi/feature/presentation/widget/appbar_widget.dart';
import 'package:sistem_presensi/feature/presentation/widget/camera_widget.dart';
import 'package:sistem_presensi/main.dart';

class CameraPage extends StatelessWidget {
  const CameraPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CTitleAppBar(title: 'Foto Dokumen',),
      ),
      body: CCameraWidget(camera: cameras.first),
    );
  }
}