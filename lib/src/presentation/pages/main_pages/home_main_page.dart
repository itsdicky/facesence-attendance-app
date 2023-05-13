import 'package:flutter/material.dart';
import 'package:sistem_presensi/src/presentation/styles/color_style.dart';
import 'package:sistem_presensi/src/presentation/widget/main_card_widget.dart';
import 'package:sistem_presensi/src/presentation/widget/presence_widget.dart';
import 'package:sistem_presensi/src/presentation/widget/common/card_widget.dart';
import 'package:sistem_presensi/utils/scroll_behavior.dart';
import 'package:timelines/timelines.dart';

import '../../../data/remote/model/user_model.dart';

class HomeMainPage extends StatelessWidget {
  static const String name = 'Dicky Satria Gemilang';
  static const String grade = 'XI Science';
  static const int presence = 24;
  static const int absence = 1;
  static const List schedule = [
    ['Matematika', '07:30-09:10'],
    ['Geografi', '09:10-10:30'],
    ['Sosiologi', '10:30-12:00'],
    ['Biologi', '12:00-13:40'],
    ['Bahasa Inggris', '13:40-14:30']
  ];
  final UserModel user;

  const HomeMainPage({super.key, required this.user});

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
                MainCard(
                  grade: user.userInfo?['classroom'],
                  name: user.userInfo?['name'],
                  presence: presence,
                  absence: absence,
                ),
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
                _buildScheduleTimeline(context),
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

  Widget _buildScheduleTimeline(BuildContext context) {
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
        contentsBuilder: (context, index) => CScheduleCard(subject: schedule[index][0], time: schedule[index][1],),
        itemCount: schedule.length,
      ),
    );
  }
}