import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sistem_presensi/src/presentation/cubit/auth/auth_cubit.dart';
import 'package:sistem_presensi/src/presentation/cubit/schedule/schedule_cubit.dart';
import 'package:sistem_presensi/src/presentation/styles/color_style.dart';
import 'package:sistem_presensi/src/presentation/widget/main_card_widget.dart';
import 'package:sistem_presensi/src/presentation/widget/presence_widget.dart';
import 'package:sistem_presensi/src/presentation/widget/common/card_widget.dart';
import 'package:sistem_presensi/utils/scroll_behavior.dart';
import 'package:timelines/timelines.dart';

import '../../../../constant/schedule_time_const.dart';
import '../../cubit/auth/auth_state.dart';

class HomeMainPage extends StatelessWidget {
  static const int presence = 24;
  static const int absence = 1;
  static const List schTime = ScheduleTime.schTime;

  const HomeMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          ScrollConfiguration(
            behavior: NoGlowScrollBehavior(),
            child: ListView(
              children: [
                BlocBuilder<AuthCubit, AuthState>(builder: (context, authState) {
                  if (authState is Authenticated) {
                    print('log widget: ${authState.userInfo}');
                    return MainCard(
                      grade: authState.userInfo['classroom'],
                      name: authState.userInfo['name'],
                      presence: presence,
                      absence: absence,
                    );
                  }
                  return const Center(child: CircularProgressIndicator(),);
                }),
                const SizedBox(
                  height: 32,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(
                    'Jadwal Hari Ini',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                BlocBuilder<ScheduleCubit, ScheduleState>(
                    builder: (context, schState) {
                      if (schState is ScheduleLoaded) {
                        return _buildScheduleTimeline(context, schState.schedule, schTime);
                      }
                      return const Center(child: CircularProgressIndicator());
                    }
                ),
                // _buildScheduleTimeline(context),
                const SizedBox(height: 110,),
              ],
            ),
          ),
          const Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: PresenceCard(),
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleTimeline(BuildContext context, List schedule, List schTime) {
    return FixedTimeline.tileBuilder(
      theme: TimelineThemeData(
          nodePosition: 0,
          indicatorPosition: 0,
          // color: Theme.of(context).primaryColor,
          indicatorTheme: const IndicatorThemeData(size: 20, color: ColorStyle.indigoPurple,),
          connectorTheme: const ConnectorThemeData(
            thickness: 5,
            space: 46,
            color: ColorStyle.indigoLight,
          )
      ),
      builder: TimelineTileBuilder.fromStyle(
        contentsAlign: ContentsAlign.basic,
        contentsBuilder: (context, index) => CScheduleCard(subject: schedule[index], time: schTime[index],),
        itemCount: schedule.length,
      ),
    );
  }
}