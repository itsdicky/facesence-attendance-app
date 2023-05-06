import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CHomeAppBar extends StatelessWidget {
  const CHomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Halo!'),
      backgroundColor: Theme.of(context).canvasColor,
      elevation: 0,
      titleTextStyle: Theme.of(context).textTheme.titleSmall,
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
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications_none_outlined),
          splashRadius: 28.0,
        ),
        const SizedBox(width: 16,)
      ],
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Theme.of(context).canvasColor,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
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
      titleTextStyle: Theme.of(context).textTheme.titleMedium,
    );
  }
}