import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sistem_presensi/feature/presentation/cubit/auth/auth_cubit.dart';
import 'package:sistem_presensi/feature/presentation/cubit/presence/presence_cubit.dart';
import 'package:sistem_presensi/feature/presentation/cubit/presence/presence_state.dart';
import 'package:sistem_presensi/feature/presentation/widget/main_card_widget.dart';

class HomePage extends StatefulWidget {
  final String uid;
  const HomePage({Key? key, required this.uid}): super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void initState() {
    //TODO: what is this?
    BlocProvider.of<PresenceCubit>(context).getPresence(uid: widget.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Demo Home Page'),
      ),
      body: BlocBuilder<PresenceCubit, PresenceState>(builder: (context, presenceState){
        if(presenceState is PresenceLoaded) {
          return _bodyWidget();
        }
        return Center(child: CircularProgressIndicator(),);
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          BlocProvider.of<AuthCubit>(context).loggedOut();
        },
        tooltip: 'logou',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _noPresenceWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          Text(
            'No presences yet',
          ),
          MainCard(),
        ],
      ),
    );
  }

  Widget _bodyWidget() {
    return Center(child: Text('Home'),);
  }
}