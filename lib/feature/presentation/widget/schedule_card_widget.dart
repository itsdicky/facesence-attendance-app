import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScheduleCard extends StatelessWidget {
  final String subject;
  final String time;

  const ScheduleCard({super.key, required this.subject, required this.time});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              subject,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),
            Text(
              time,
              style: const TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 14,
                color: Colors.black26,
              ),
            ),
          ],
        ),
      ),
    );
  }
}