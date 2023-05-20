import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sistem_presensi/constant/page_const.dart';
import 'package:sistem_presensi/src/presentation/styles/color_style.dart';
import 'package:sistem_presensi/src/presentation/widget/common/appbar_widget.dart';

import '../../cubit/permission/add_permission/add_permission_cubit.dart';

class PictureDisplayPage extends StatelessWidget {

  const PictureDisplayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CTitleAppBarLight(title: 'Gunakan gambar ini?',),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            BlocBuilder<AddPermissionCubit, AddPermissionState>(
              buildWhen: (prev, next) => prev is AddPermissionLoading && next is AddPermissionPreview,
              builder: (context, presenceState) {
                if (presenceState is AddPermissionPreview) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(presenceState.file),
                  );
                } else {
                  return const CardLoading(
                    height: 450,
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    // margin: EdgeInsets.only(bottom: 10),
                  );
                }
              },
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
                  BlocBuilder<AddPermissionCubit, AddPermissionState>(
                    builder: (context, permissionState) {
                      if (permissionState is AddPermissionPreview) {
                        return FloatingActionButton(
                          heroTag: 'Accept',
                          elevation: 0,
                          backgroundColor: ColorStyle.limeGreen,
                          onPressed: () {
                            Navigator.pushNamed(context, PageConst.permissionPreviewPage, arguments: [
                              permissionState.category,
                              permissionState.desc,
                              permissionState.file
                            ]);
                          },
                          child: const Icon(Icons.check),
                        );
                      } else {
                        return FloatingActionButton(
                          heroTag: 'Accept',
                          elevation: 0,
                          backgroundColor: ColorStyle.limeGreen,
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Tunggu beberapa saat')));
                          },
                          child: const Center(
                            child: SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(color: ColorStyle.white,),
                            ),
                          ),
                        );
                      }
                    },
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