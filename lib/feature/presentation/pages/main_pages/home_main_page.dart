import 'package:flutter/material.dart';
import 'package:sistem_presensi/feature/presentation/widget/main_card_widget.dart';
import 'package:sistem_presensi/feature/presentation/widget/presence_widget.dart';
import 'package:sistem_presensi/feature/presentation/widget/schedule_card_widget.dart';
import 'package:sistem_presensi/utils/scroll_behavior.dart';

class HomeMainPage extends StatelessWidget {
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
                  grade: 'XII Science',
                  name: 'Dicky Satria Gemilang',
                  presence: 24,
                  absence: 1,
                ),
                const SizedBox(
                  height: 32,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Text(
                    'Jadwal Hari Ini',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                const ScheduleCard(subject: 'math', time: '07:30-09:10',),
                const ScheduleCard(subject: 'geography', time: '09:10-10:30',),
                const ScheduleCard(subject: 'sociology', time: '10:30-12:00',),
                const ScheduleCard(subject: 'biology', time: '12:00-13:40',),
                const ScheduleCard(subject: 'english', time: '13:40-14:30',),
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
}