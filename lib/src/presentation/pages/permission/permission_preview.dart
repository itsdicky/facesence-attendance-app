import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sistem_presensi/src/presentation/styles/color_style.dart';
import 'package:sistem_presensi/src/presentation/styles/widget_style.dart';
import 'package:sistem_presensi/src/presentation/widget/common/appbar_widget.dart';

import '../../../domain/entities/permission_entity.dart';
import '../../cubit/permission/add_permission/add_permission_cubit.dart';

class PermissionPreviewPage extends StatelessWidget {
  final String category;
  final String description;
  final String imagePath;

  const PermissionPreviewPage({super.key, required this.category, required this.description, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddPermissionCubit, AddPermissionState>(
      listener: (context, permissionState) {
        if (permissionState is AddPermissionSuccess) {
          Navigator.popUntil(context, (route) => route.isFirst);
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Presensi berhasil')));
        }
        if (permissionState is AddPermissionFailure) {
          Navigator.popUntil(context, (route) => route.isFirst);
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Presensi tidak berhasil')));
        }
      },
      child: Scaffold(
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
                    File imageFile = File(imagePath);
                    BlocProvider.of<AddPermissionCubit>(context).addPermission(
                        permission: PermissionEntity(
                          category: category,
                          description: description,
                          imageFile: imageFile
                        ),
                    );
                  },
                  child: Text('Kirim', style: Theme.of(context).textTheme.titleSmall?.copyWith(color: ColorStyle.white),),
                ),
              ],
            ),
          ),
        ),
    );
  }

}