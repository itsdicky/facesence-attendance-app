import 'package:flutter/material.dart';
import 'package:sistem_presensi/feature/presentation/widget/main_card_widget.dart';
import 'package:sistem_presensi/feature/presentation/widget/presence_widget.dart';
import 'package:sistem_presensi/feature/presentation/widget/schedule_card_widget.dart';
import 'package:sistem_presensi/utils/scroll_behavior.dart';
import 'package:timelines/timelines.dart';

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
                const MainCard(
                  grade: grade,
                  name: name,
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
        indicatorTheme: IndicatorThemeData(size: 20, color: Theme.of(context).primaryColor,),
        connectorTheme: ConnectorThemeData(
          thickness: 5,
          space: 46,
          color: Theme.of(context).primaryColorLight,
        )
      ),
      builder: TimelineTileBuilder.fromStyle(
        contentsAlign: ContentsAlign.basic,
        contentsBuilder: (context, index) => ScheduleCard(subject: schedule[index][0], time: schedule[index][1],),
        itemCount: schedule.length,
      ),
    );
  }
}