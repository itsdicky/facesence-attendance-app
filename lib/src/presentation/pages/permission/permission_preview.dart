import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sistem_presensi/src/presentation/styles/color_style.dart';
import 'package:sistem_presensi/src/presentation/styles/widget_style.dart';
import 'package:sistem_presensi/src/presentation/widget/common/appbar_widget.dart';

class PermissionPreviewPage extends StatelessWidget {
  final String category;
  final String description;
  final String imagePath;

  const PermissionPreviewPage({super.key, required this.category, required this.description, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CTitleAppBarLight(title: 'Detail Izin'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.file(File(imagePath), height: 320, width: MediaQuery.of(context).size.width, fit: BoxFit.cover,),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 32,),
                    Text('Keterangan: $category', style: Theme.of(context).textTheme.titleLarge,),
                    const SizedBox(height: 12,),
                    Text(description, style: Theme.of(context).textTheme.bodyMedium,),
                  ],
                ),
              ),
            ),
            TextButton(
              style: CWidgetStyle.textButtonStyle(),
              onPressed: () {
                // Navigator.pushNamed(context, PageConst.cameraPage);
              },
              child: Text('Kirim', style: Theme.of(context).textTheme.titleSmall?.copyWith(color: ColorStyle.white),),
            ),
          ],
        ),
      ),
    );
  }

}