import 'package:flutter/material.dart';

class CHomeAppBar extends StatelessWidget {
  const CHomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Halo!'),
      backgroundColor: Theme.of(context).canvasColor,
      elevation: 0,
      titleTextStyle: TextStyle(color: Theme.of(context).shadowColor, fontWeight: FontWeight.w700),
      iconTheme: IconThemeData(
        color: Theme.of(context).shadowColor,
      ),
      leading: const Padding(
        padding: EdgeInsets.fromLTRB(12, 10, 0, 10),
        child: CircleAvatar(
          backgroundImage: NetworkImage('https://images.unsplash.com/photo-1682965636199-091797901722?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80'),
          radius: 100,
        ),
      ),
      actions: const [
        Icon(Icons.notifications_none),
        SizedBox(width: 24,)
      ],
    );
  }
}

class CTitleAppBar extends StatelessWidget {
  final String title;

  const CTitleAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).canvasColor,
      elevation: 0,
      title: Center(child: Text(title)),
      titleTextStyle: TextStyle(color: Theme.of(context).shadowColor, fontSize: 16, fontWeight: FontWeight.w700),
    );
  }
}