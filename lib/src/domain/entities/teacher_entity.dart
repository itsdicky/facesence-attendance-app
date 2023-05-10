import 'package:equatable/equatable.dart';

class TeacherEntity extends Equatable {
  final String? name;
  final String? subject;
  final String? grade;
  final String? email;
  final String? password;
  final int? nip;

  const TeacherEntity({
    this.name,
    this.subject,
    this.grade,
    this.email,
    this.password,
    this.nip,
  });

  @override
  List<Object?> get props => [
    name,
    subject,
    grade,
    email,
    password,
    nip,
  ];
}