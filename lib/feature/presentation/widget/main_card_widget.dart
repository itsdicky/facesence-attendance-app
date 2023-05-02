import 'package:flutter/material.dart';

class MainCard extends StatelessWidget {
  const MainCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(50),
        child: Column(
          children: const <Widget>[
            Text('Student Name'),
            Text('Class'),
            Text('20'),
            Text('2'),
          ],
        ),
      )
    );
  }
}