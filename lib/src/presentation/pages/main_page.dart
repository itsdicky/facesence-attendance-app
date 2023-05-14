import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sistem_presensi/src/presentation/cubit/navbar/navbar_cubit.dart';
import 'package:sistem_presensi/src/presentation/cubit/schedule/schedule_cubit.dart';
import 'package:sistem_presensi/src/presentation/pages/main_pages/history_main_page.dart';
import 'package:sistem_presensi/src/presentation/pages/main_pages/home_main_page.dart';
import 'package:sistem_presensi/src/presentation/pages/main_pages/permission_main_page.dart';
import 'package:sistem_presensi/src/presentation/pages/main_pages/profile_main_page.dart';
import 'package:sistem_presensi/src/presentation/widget/common/appbar_widget.dart';
import 'package:sistem_presensi/src/presentation/widget/bottom_navbar_widget.dart';

class MainPage extends StatefulWidget {
  final String uid;
  final Map<String, dynamic> userInfo;
  const MainPage({Key? key, required this.uid, required this.userInfo}): super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  //TODO: change to stateless and use blocprovider for call cubit function?
  int _currentIndex = 0;

  @override
  void initState() {
    BlocProvider.of<NavbarCubit>(context).openMainPage();
    BlocProvider.of<ScheduleCubit>(context).getTodaySchedule();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: BlocBuilder<NavbarCubit, NavbarState>(
          builder: (context, navState) {
            if (navState is NavbarHome) {
              return const CHomeAppBar();
            }
            if (navState is NavbarHistory) {
              return CTitleAppBarLight(title: navState.title);
            }
            if (navState is NavbarPermission) {
              return CTitleAppBarLight(title: navState.title);
            }
            if (navState is NavbarProfile) {
              return CTitleAppBarLight(title: navState.title);
            }
            return AppBar(title: const Text(''),);
          },
        ),
      ),
      bottomNavigationBar: BlocConsumer<NavbarCubit, NavbarState>(
        builder: (context, navState) {
          return BottomNavBar(currentIndex: _currentIndex,);
        },
        listener: (context, navState) {
          if (navState is NavbarHome) {
            _currentIndex = 0;
          }
          if (navState is NavbarHistory) {
            _currentIndex = 1;
          }
          if (navState is NavbarPermission) {
            _currentIndex = 2;
          }
          if (navState is NavbarProfile) {
            _currentIndex = 3;
          }
        },
      ),
      body: BlocBuilder<NavbarCubit, NavbarState>(
        builder: (context, navState) {
          if (navState is NavbarHome) {
            return const HomeMainPage();
          }
          if (navState is NavbarHistory) {
            return const HistoryMainPage();
          }
          if (navState is NavbarPermission) {
            return const PermissionMainPage();
          }
          if (navState is NavbarProfile) {
            return const ProfileMainPage();
          }
          return const Center(child: CircularProgressIndicator(),);
        },
      ),
    );
  }

  void onTapNavigate(int index) {
    BlocProvider.of<NavbarCubit>(context).moveIndex(index);
  }
}