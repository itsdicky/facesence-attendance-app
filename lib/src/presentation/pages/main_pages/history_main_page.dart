import 'package:flutter/material.dart';
import 'package:sistem_presensi/src/presentation/styles/color_style.dart';
import 'package:sistem_presensi/src/presentation/widget/calendar_widget.dart';

class HistoryMainPage extends StatelessWidget {
  const HistoryMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
            child: ListView(
              children: [
                Card(
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
                              'Hadir',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              'Berhasil hadir tepat waktu',
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                          ],
                        ),
                        Text(
                          '07:29',
                          style: Theme.of(context).textTheme.labelMedium?.copyWith(color: ColorStyle.darkGrey),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
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
                              'Hadir',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              'Berhasil hadir tepat waktu',
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                          ],
                        ),
                        Text(
                          '07:29',
                          style: Theme.of(context).textTheme.labelMedium?.copyWith(color: ColorStyle.darkGrey),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}