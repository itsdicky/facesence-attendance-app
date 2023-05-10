import 'package:flutter/material.dart';
import 'package:sistem_presensi/src/presentation/styles/color_style.dart';
import 'package:sistem_presensi/src/presentation/widget/common/appbar_widget.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CTitleAppBarLight(title: 'Notifikasi',),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
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
                          'Izin',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          'Izin telah dikonfirmasi',
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ],
                    ),
                    Text(
                      '07:42',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(color: ColorStyle.darkGrey),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}