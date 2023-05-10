import 'package:flutter/material.dart';
import 'package:sistem_presensi/src/presentation/styles/color_style.dart';

class CAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final void Function() onPressed;

  const CAlertDialog({super.key, required this.title, required this.content, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: Text('Tidak', style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: ColorStyle.indigoPurple),),
        ),
        TextButton(
          onPressed: () {
            onPressed.call();
            Navigator.pop(context, 'Cancel');
          },
          child: Text('Ya', style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: ColorStyle.indigoPurple),),
        ),
      ],
      titleTextStyle: Theme.of(context).textTheme.titleLarge,
      contentTextStyle: Theme.of(context).textTheme.bodyLarge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

}