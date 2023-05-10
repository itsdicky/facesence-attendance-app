import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sistem_presensi/src/presentation/cubit/navbar/navbar_cubit.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;

  const BottomNavBar({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      unselectedItemColor: Theme.of(context).shadowColor,
      selectedItemColor: Theme.of(context).primaryColor,
      onTap: (index) {
        BlocProvider.of<NavbarCubit>(context).moveIndex(index);
      },
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
  }

  // void onTapNavigate(int index) {
  //   BlocProvider.of<NavbarCubit>(context).moveIndex(index);
  // }
}