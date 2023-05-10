import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sistem_presensi/constant/page_const.dart';
import 'package:sistem_presensi/src/presentation/styles/color_style.dart';
import 'package:sistem_presensi/src/presentation/widget/common/appbar_widget.dart';

class PictureDisplayPage extends StatelessWidget {
  final String imagePath;

  const PictureDisplayPage({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CTitleAppBarLight(title: 'Gunakan gambar ini?',),
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
                    heroTag: 'Discard',
                    elevation: 0,
                    backgroundColor: ColorStyle.offRed,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.close),
                  ),
                  FloatingActionButton(
                    heroTag: 'Accept',
                    elevation: 0,
                    backgroundColor: ColorStyle.limeGreen,
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