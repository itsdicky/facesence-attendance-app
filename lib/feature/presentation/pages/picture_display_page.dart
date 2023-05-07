import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sistem_presensi/app_const.dart';
import 'package:sistem_presensi/feature/presentation/widget/appbar_widget.dart';

class PictureDisplayPage extends StatelessWidget {
  final String imagePath;

  const PictureDisplayPage({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CTitleAppBar(title: 'Gunakan gambar ini?',),
      ),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.file(File(imagePath)),
            ),
            // const SizedBox(height: 64,),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingActionButton(
                    elevation: 4,
                    backgroundColor: Colors.red,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.close),
                  ),
                  FloatingActionButton(
                    elevation: 4,
                    backgroundColor: Colors.green,
                    onPressed: () {
                      Navigator.pushNamed(context, PageConst.permissionPreviewPage, arguments: imagePath);
                    },
                    child: const Icon(Icons.check),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}