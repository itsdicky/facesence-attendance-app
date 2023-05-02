import 'package:equatable/equatable.dart';

class StudentEntity extends Equatable {
  final String? name;
  final String? grade;
  final String? email;
  final String? password;
  final int? nis;

  const StudentEntity({
    this.name,
    this.grade,
    this.email,
    this.password,
    this.nis,
  });

  @override
  List<Object?> get props => [
    name,
    grade,
    email,
    password,
    nis,
  ];
}