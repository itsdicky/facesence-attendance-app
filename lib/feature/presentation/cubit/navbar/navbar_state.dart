part of 'navbar_cubit.dart';

@immutable
abstract class NavbarState extends Equatable {
  const NavbarState();
}

class NavbarInitial extends NavbarState {
  @override
  List<Object?> get props => [];
}

class NavbarHome extends NavbarState {
  final String title = 'Beranda';

  @override
  List<Object?> get props => [];
}

class NavbarHistory extends NavbarState {
  final String title = 'Riwayat';

  @override
  List<Object?> get props => [];
}

class NavbarPermission extends NavbarState {
  final String title = 'Izin';

  @override
  List<Object?> get props => [];
}

class NavbarProfile extends NavbarState {
  final String title = 'Profil';

  @override
  List<Object?> get props => [];
}
