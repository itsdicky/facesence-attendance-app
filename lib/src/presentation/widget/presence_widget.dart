import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sistem_presensi/constant/page_const.dart';
import 'package:sistem_presensi/src/presentation/styles/color_style.dart';

class PresenceCard extends StatefulWidget {

  const PresenceCard({super.key});

  @override
  State<PresenceCard> createState() => _PresenceCardState();
}

class _PresenceCardState extends State<PresenceCard> {
  late String _dayString;
  late String _dateString;
  late String _timeString;

  @override
  void initState() {
    DateTime now = DateTime.now();
    _dayString = _formatDay(now);
    _dateString = _formatDate(now);
    _timeString = _formatTime(now);
    Timer.periodic(const Duration(seconds: 1), (timer) => _getTime());
    super.initState();
  }

  @override
  void setState(fn) {
    if(mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(context) {
    return Card(
      color: ColorStyle.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: SizedBox(
        height: 100,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _dayString,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(color: ColorStyle.white),
                      ),
                      Text(
                        _dateString,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(color: ColorStyle.white),
                      ),
                    ],
                  ),
                  Text(
                    _timeString,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(color: ColorStyle.white),
                  ),
                ],
              ),
              Row(
                children: [
                  Material(
                    type: MaterialType.transparency,
                    child: Ink(
                      decoration: BoxDecoration(
                        border: Border.all(color: ColorStyle.white ,width: 2),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(8.0),
                        onTap: (){
                          Navigator.pushNamed(context, PageConst.askPermissionPage);
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Icon(
                            Icons.document_scanner_outlined,
                            size: 24,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12,),
                  Material(
                    type: MaterialType.transparency,
                    child: Ink(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color: ColorStyle.indigoPurple,
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(8.0),
                        onTap: (){
                          Navigator.pushNamed(context, PageConst.presenceCameraPage);
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Icon(
                            Icons.assignment_turned_in_outlined,
                            size: 24,
                            color: ColorStyle.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDay = _formatDay(now);
    final String formattedDate = _formatDate(now);
    final String formattedTime = _formatTime(now);
    setState(() {
      _dayString = formattedDay;
      _dateString = formattedDate;
      _timeString = formattedTime;
    });
  }

  String _formatDay(DateTime dateTime) {
    return DateFormat('EEEE').format(dateTime);
  }

  String _formatDate(DateTime dateTime) {
    return DateFormat('dd MMMM').format(dateTime);
  }

  String _formatTime(DateTime dateTime) {
    return DateFormat('hh:mm:ss').format(dateTime);
  }
}