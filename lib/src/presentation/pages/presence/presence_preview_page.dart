import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sistem_presensi/src/presentation/cubit/presence/add_presence/add_presence_state.dart';
import 'package:sistem_presensi/src/presentation/styles/color_style.dart';
import 'package:sistem_presensi/src/presentation/widget/common/appbar_widget.dart';
import 'package:sistem_presensi/utils/geo_util.dart';

import '../../../domain/entities/presence_entity.dart';
import '../../cubit/presence/add_presence/add_presence_cubit.dart';

class PresencePreviewPage extends StatelessWidget {

  const PresencePreviewPage({super.key});

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
          Navigator.pop(context);
          final failMessage = presenceState.message;
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Terjadi kesalahan: $failMessage')));
        }
      },
      child: Scaffold(
          appBar: const PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: CTitleAppBarLight(title: 'Kirim presensi?',),
          ),
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                BlocBuilder<AddPresenceCubit, AddPresenceState>(
                  buildWhen: (prev, next) => prev is AddPresenceLoading && next is AddPresencePreview,
                  builder: (context, presenceState) {
                    if (presenceState is AddPresencePreview) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(presenceState.image),
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
                const SizedBox(height: 20,),
                BlocBuilder<AddPresenceCubit, AddPresenceState>(
                  buildWhen: (prev, next) => prev is AddPresenceLoading && next is AddPresencePreview,
                  builder: (context, presenceState) {
                    if (presenceState is AddPresencePreview) {
                      return Column(
                        children: [
                          Text(
                            presenceState.dateTimeString,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(height: 4,),
                          FutureBuilder(
                            builder: (context, snapshot) {
                              return SizedBox(
                                width: 300,
                                child: Text(snapshot.data.toString(), textAlign: TextAlign.center,),
                              );
                            },
                            future: CGeoUtil.getAddress(presenceState.geoPoint),
                          )
                        ],
                      );
                    } else {
                      return Column(
                        children: [
                          CardLoading(
                            height: 20,
                            width: 200,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          const SizedBox(height: 8,),
                          CardLoading(
                            height: 18,
                            width: 300,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ],
                      );
                    }
                  },
                ),
                const SizedBox(height: 16,),
                const Divider(),
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
                      SizedBox(
                        height: 56,
                        child: FittedBox(
                          child: BlocBuilder<AddPresenceCubit, AddPresenceState>(
                            builder: (context, presenceState) {
                              if (presenceState is AddPresencePreview) {
                                return FloatingActionButton.extended(
                                  heroTag: 'Accept',
                                  isExtended: true,
                                  elevation: 0,
                                  backgroundColor: ColorStyle.limeGreen,
                                  onPressed: () {
                                    BlocProvider.of<AddPresenceCubit>(context).addPresence(
                                        presence: PresenceEntity(
                                          isPresence: true,
                                          imageFile: presenceState.image,
                                          time: presenceState.timestamp,
                                          location: presenceState.geoPoint
                                        ),
                                    );
                                  },
                                  label: Row(
                                    children: const [
                                      Icon(Icons.send),
                                      SizedBox(width: 12,),
                                      Text('Kirim'),
                                    ],
                                  ),
                                );
                              } else {
                                return FloatingActionButton.extended(
                                  heroTag: 'Accept',
                                  isExtended: true,
                                  elevation: 0,
                                  backgroundColor: ColorStyle.limeGreen,
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('Tunggu beberapa saat')));
                                  },
                                  label: Row(
                                    children: const [
                                      Center(
                                        child: SizedBox(
                                          height: 24,
                                          width: 24,
                                          child: CircularProgressIndicator(color: ColorStyle.white,),
                                        ),
                                      ),
                                      SizedBox(width: 12,),
                                      Text('Kirim'),
                                    ],
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}