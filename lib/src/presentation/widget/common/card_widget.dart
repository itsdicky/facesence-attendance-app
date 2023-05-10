import 'package:flutter/material.dart';
import 'package:sistem_presensi/src/presentation/styles/color_style.dart';

class CScheduleCard extends StatelessWidget {
  final String subject;
  final String time;

  const CScheduleCard({super.key, required this.subject, required this.time});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              subject,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              time,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(color: ColorStyle.darkGrey),
            ),
          ],
        ),
      ),
    );
  }
}