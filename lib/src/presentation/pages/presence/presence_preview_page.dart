import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sistem_presensi/src/presentation/styles/color_style.dart';
import 'package:sistem_presensi/src/presentation/widget/common/appbar_widget.dart';

import '../../../domain/entities/presence_entity.dart';
import '../../cubit/presence/presence_cubit.dart';

class PresencePreviewPage extends StatelessWidget {
  final String imagePath;
  final Timestamp timestamp;

  const PresencePreviewPage({super.key, required this.imagePath, required this.timestamp});

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
            const SizedBox(height: 16,),
            Text(timestamp.toString()),
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
                      File imageFile = File(imagePath);

                      BlocProvider.of<PresenceCubit>(context).addPresence(
                          presence: PresenceEntity(isPresence: true, imageFile: imageFile, time: timestamp)
                      );
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