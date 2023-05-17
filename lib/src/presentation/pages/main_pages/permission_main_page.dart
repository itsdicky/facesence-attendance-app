import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sistem_presensi/src/domain/entities/permission_entity.dart';
import 'package:sistem_presensi/src/presentation/cubit/permission/load_permission/load_permission_cubit.dart';
import 'package:sistem_presensi/src/presentation/styles/color_style.dart';
import 'package:sistem_presensi/utils/date_util.dart';

class PermissionMainPage extends StatelessWidget {
  const PermissionMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // const PermissionStatusBar(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 32, 8, 8),
            child: BlocBuilder<LoadPermissionCubit, LoadPermissionState>(
              builder: (context, permissionState) {
                if (permissionState is LoadPermissionSuccess) {
                  if (permissionState.presences.isNotEmpty) {
                    final List<PermissionEntity> permissionList = permissionState.presences;
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      permissionList[index].category!,
                                      style: Theme.of(context).textTheme.titleSmall,
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      permissionList[index].isConfirmed! ? permissionList[index].status! :'Menunggu dikonfirmasi',
                                      style: Theme.of(context).textTheme.labelLarge,
                                    ),
                                  ],
                                ),
                                Text(
                                  CDateUtil.getTimeString(permissionList[index].time!.toDate()),
                                  style: Theme.of(context).textTheme.labelMedium?.copyWith(color: ColorStyle.darkGrey),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: permissionList.length,
                    );
                  } else {
                    return const Center(child: Text('Tidak ada izin hari ini'));
                  }
                }
                return const Center(child: CircularProgressIndicator(),);
              },
            ),
          ),
        ),
      ],
    );
  }
}