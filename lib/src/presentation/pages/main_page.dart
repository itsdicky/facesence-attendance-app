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
import '../../../injection_container.dart' as di;

class MainPage extends StatelessWidget {
  final String uid;
  final Map<String, dynamic> userInfo;
  const MainPage({Key? key, required this.uid, required this.userInfo}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ScheduleCubit>(create: (_) => di.sl<ScheduleCubit>()..getTodaySchedule()),
      ],
      child: Scaffold(
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
        bottomNavigationBar: BlocSelector<NavbarCubit, NavbarState, int>(
          selector: (state) => state.index,
          builder: (context, state) {
            if (state == 0) {
              return BottomNavBar(currentIndex: state);
            }
            if (state == 1) {
              return BottomNavBar(currentIndex: state);
            }
            if (state == 2) {
              return BottomNavBar(currentIndex: state);
            }
            if (state == 3) {
              return BottomNavBar(currentIndex: state);
            }
            return const BottomNavBar(currentIndex: 0);
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
      ),
    );
  }
}