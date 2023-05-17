import 'package:flutter/material.dart';

import '../styles/color_style.dart';

class PermissionStatusBar extends StatelessWidget {

  const PermissionStatusBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}