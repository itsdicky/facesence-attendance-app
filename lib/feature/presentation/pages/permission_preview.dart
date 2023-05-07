import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sistem_presensi/feature/presentation/styles/color_style.dart';
import 'package:sistem_presensi/feature/presentation/styles/widget_style.dart';
import 'package:sistem_presensi/feature/presentation/widget/appbar_widget.dart';

class PermissionPreviewPage extends StatelessWidget {
  final String imagePath;

  const PermissionPreviewPage({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CTitleAppBar(title: 'Detail Izin'),
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
                    Text('Keterangan: Izin', style: Theme.of(context).textTheme.titleLarge,),
                    const SizedBox(height: 12,),
                    Text('Ini deskripsi', style: Theme.of(context).textTheme.bodyMedium,),
                  ],
                ),
              ),
            ),
            TextButton(
              style: WidgetStyle.textButtonStyle(),
              onPressed: () {
                // Navigator.pushNamed(context, PageConst.cameraPage);
              },
              child: Text('Lanjut', style: Theme.of(context).textTheme.titleSmall?.copyWith(color: ColorStyle.white),),
            ),
          ],
        ),
      ),
    );
  }

}