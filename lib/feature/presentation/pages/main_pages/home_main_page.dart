import 'package:flutter/material.dart';
import 'package:sistem_presensi/feature/presentation/widget/main_card_widget.dart';
import 'package:sistem_presensi/feature/presentation/widget/presence_widget.dart';
import 'package:sistem_presensi/feature/presentation/widget/schedule_card_widget.dart';

class HomeMainPage extends StatelessWidget {
  const HomeMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          ListView(
            children: const [
              MainCard(
                grade: 'XII Science',
                name: 'Dicky Satria Gemilang',
                presence: 24,
                absence: 1,
              ),
              SizedBox(
                height: 32,
              ),
              Padding(
                padding: EdgeInsets.only(left: 8),
                child: Text(
                  'Jadwal Hari Ini',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              ScheduleCard(subject: 'math', time: '07:30-09:10',),
              ScheduleCard(subject: 'geography', time: '09:10-10:30',),
              ScheduleCard(subject: 'sociology', time: '10:30-12:00',),
              ScheduleCard(subject: 'biology', time: '12:00-13:40',),
              ScheduleCard(subject: 'english', time: '13:40-14:30',),
            ],
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