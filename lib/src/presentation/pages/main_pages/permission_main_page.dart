import 'package:flutter/material.dart';
import 'package:sistem_presensi/src/presentation/styles/color_style.dart';

class PermissionMainPage extends StatelessWidget {
  const PermissionMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 42,
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text('07:12', style: Theme.of(context).textTheme.titleSmall?.copyWith(color: ColorStyle.white),),
                    VerticalDivider(color: Theme.of(context).cardColor, width: 32, thickness: 2,),
                    Text('Izin', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: ColorStyle.white),),
                  ],
                ),
                Row(
                  children: [
                    Text('Menunggu...', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: ColorStyle.indigoLight),),
                    const SizedBox(width: 16,),
                    const Icon(Icons.timer_outlined, color: ColorStyle.white,)
                  ],
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 32, 8, 8),
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
                          '07:12',
                          style: Theme.of(context).textTheme.labelMedium?.copyWith(color: ColorStyle.darkGrey),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}