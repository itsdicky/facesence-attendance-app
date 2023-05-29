import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sistem_presensi/constant/app_config.dart';
import 'package:sistem_presensi/src/domain/entities/presence_entity.dart';
import 'package:sistem_presensi/src/presentation/cubit/calendar/calendar_cubit.dart';
import 'package:sistem_presensi/src/presentation/styles/color_style.dart';
import 'package:sistem_presensi/src/presentation/widget/calendar_widget.dart';
import '../../../../injection_container.dart' as di;
import '../../../../utils/date_util.dart';
import '../../cubit/presence/load_presence/load_presence_cubit.dart';

class HistoryMainPage extends StatelessWidget {
  const HistoryMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CalendarCubit>(create: (context) => di.sl<CalendarCubit>(),),
      ],
      child: BlocListener<CalendarCubit, DateTime>(
            listener: (context, calendarState) {
              if (calendarState.day == DateTime.now().day) {
                print(calendarState);
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Calendar(),
                  const SizedBox(
                    height: 32,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      'Aktivitas',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Expanded(
                    child: BlocBuilder<LoadPresenceCubit, LoadPresenceState>(
                      buildWhen: (previous, current) => previous != current && current is LoadPresenceSuccess,
                      builder: (context, presenceState) {
                        if (presenceState is LoadPresenceSuccess) {
                          return BlocBuilder<CalendarCubit, DateTime>(
                            builder: (context, calendarState) {
                              final List<PresenceEntity> selectedList = CDateUtil.filterPresenceDateList(presenceState.presences, calendarState).toList();
                              if (selectedList.isNotEmpty) {
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
                                                  selectedList[index].isPresence! ? 'Hadir':'Tidak hadir',
                                                  style: selectedList[index].isPresence! == false && selectedList[index].permissionId == null ?
                                                  Theme.of(context).textTheme.titleSmall?.copyWith(color: ColorStyle.offRed)
                                                      : Theme.of(context).textTheme.titleSmall,
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                Text(
                                                  selectedList[index].isPresence! ?
                                                  CDateUtil.isTimeAfter(
                                                      dateTime: selectedList[index].time!.toDate(),
                                                      hour: AppConfig.schoolStart['hour']!,
                                                      minute: AppConfig.schoolStart['minute']!
                                                  ) ? 'Hadir terlambat' : 'Hadir tepat waktu'
                                                      : selectedList[index].permissionId != null ? 'Izin':'Alpha',
                                                  style: selectedList[index].isPresence! == false && selectedList[index].permissionId == null ?
                                                        Theme.of(context).textTheme.labelLarge?.copyWith(color: ColorStyle.offRed)
                                                      : Theme.of(context).textTheme.labelLarge,
                                                ),
                                              ],
                                            ),
                                            Text(
                                              CDateUtil.getTimeString(selectedList[index].time!.toDate()),
                                              style: Theme.of(context).textTheme.labelMedium?.copyWith(color: ColorStyle.darkGrey),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  itemCount: selectedList.length,
                                );
                              }
                              return const Center(child: Text('Belum ada aktivitas'));
                            },
                          );
                        }
                        return const Center(child: CircularProgressIndicator(),);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }
}