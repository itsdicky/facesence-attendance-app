import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sistem_presensi/feature/presentation/cubit/navbar/navbar_cubit.dart';
import 'package:sistem_presensi/feature/presentation/cubit/presence/presence_cubit.dart';
import 'package:sistem_presensi/feature/presentation/cubit/presence/presence_state.dart';
import 'package:sistem_presensi/feature/presentation/widget/main_card_widget.dart';
import 'package:sistem_presensi/feature/presentation/widget/presence_widget.dart';
import 'package:sistem_presensi/feature/presentation/widget/schedule_card_widget.dart';

class HomePage extends StatefulWidget {
  final String uid;
  const HomePage({Key? key, required this.uid}): super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  void initState() {
    //TODO: what is this?
    BlocProvider.of<PresenceCubit>(context).getPresence(uid: widget.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      ),
      bottomNavigationBar: BlocBuilder<NavbarCubit, NavbarState>(
        builder: (context, navbarState) {
          return BottomNavigationBar(
            currentIndex: _currentIndex,
            unselectedItemColor: Theme.of(context).shadowColor,
            selectedItemColor: Theme.of(context).primaryColor,
            onTap: onTapNavigate,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_outlined,
                ),
                activeIcon: Icon(
                  Icons.home,
                ),
                label: 'Beranda',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.history_outlined,
                ),
                activeIcon: Icon(
                  Icons.history,
                ),
                label: 'Riwayat',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.document_scanner_outlined,
                ),
                activeIcon: Icon(
                  Icons.document_scanner,
                ),
                label: 'Izin',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person_outline,
                ),
                activeIcon: Icon(
                  Icons.person,
                ),
                label: 'Profil',
              ),
            ],
          );
        },
      ),
      body: BlocConsumer<NavbarCubit, NavbarState>(
        builder: (context, navbarState) {
          if (navbarState is NavbarHome) {
            return BlocBuilder<PresenceCubit, PresenceState>(builder: (context, presenceState){
              if(presenceState is PresenceLoaded) {
                return _bodyWidget();
              }
              return const Center(child: CircularProgressIndicator(),);
            });
          }
          if (navbarState is NavbarHistory) {
            return const Center(child: Text('History'),);
          }
          if (navbarState is NavbarPermission) {
            return const Center(child: Text('Permission'),);
          }
          if (navbarState is NavbarProfile) {
            return const Center(child: Text('Profile'),);
          }
          return const Text('Default');
        },
        listener: (context, navbarState) {
          if (navbarState is NavbarHome) {
            _currentIndex = 0;
          }
          if (navbarState is NavbarHistory) {
            _currentIndex = 1;
          }
          if (navbarState is NavbarPermission) {
            _currentIndex = 2;
          }
          if (navbarState is NavbarProfile) {
            _currentIndex = 3;
          }
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     BlocProvider.of<AuthCubit>(context).loggedOut();
      //   },
      //   tooltip: 'logou',
      //   child: const Icon(Icons.add),
      // ),
    );
  }

  Widget _bodyWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          ListView(
            children: const [
              MainCard(
                grade: 'XII Science',
                name: 'Dicky Satria Gemilang',
                presence: 24,
                absence: 1,
              ),
              SizedBox(
                height: 32,
              ),
              Padding(
                padding: EdgeInsets.only(left: 8),
                child: Text(
                  'Jadwal',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              ScheduleCard(),
              ScheduleCard(),
              ScheduleCard(),
              ScheduleCard(),
              ScheduleCard(),
            ],
          ),
          const Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: PresenceCard(),
          ),
        ],
      ),
    );
  }

  void onTapNavigate(int index) {
    BlocProvider.of<NavbarCubit>(context).moveIndex(index);
  }
}