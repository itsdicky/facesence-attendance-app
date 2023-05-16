part of 'navbar_cubit.dart';

@immutable
abstract class NavbarState extends Equatable {
  abstract final String title;
  abstract final int index;

  const NavbarState();
}

// class NavbarInitial extends NavbarState {
//   @override
//   List<Object?> get props => [];
// }

class NavbarHome extends NavbarState {
  @override
  final String title = 'Beranda';
  @override
  final int index = 0;

  const NavbarHome() : super();

  @override
  List<Object?> get props => [];
}

class NavbarHistory extends NavbarState {
  @override
  final String title = 'Riwayat';
  @override
  final int index = 1;

  const NavbarHistory() : super();

  @override
  List<Object?> get props => [];
}

class NavbarPermission extends NavbarState {
  @override
  final String title = 'Izin';
  @override
  final int index = 2;

  const NavbarPermission() : super();

  @override
  List<Object?> get props => [];
}

class NavbarProfile extends NavbarState {
  @override
  final String title = 'Profil';
  @override
  final int index = 3;

  const NavbarProfile() : super();

  @override
  List<Object?> get props => [];
}
