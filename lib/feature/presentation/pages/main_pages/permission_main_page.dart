import 'package:flutter/material.dart';
import 'package:sistem_presensi/feature/presentation/styles/color_style.dart';

class PermissionMainPage extends StatelessWidget {
  const PermissionMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
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
                        'Menunggu izin dikonfirmasi',
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
    );
  }
}