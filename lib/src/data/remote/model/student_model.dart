import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sistem_presensi/src/domain/entities/student_entity.dart';

class StudentModel extends StudentEntity{
  const StudentModel({
    final String? name,
    final String? grade,
    final String? email,
    final String? password,
    final int? nis,
  }): super(
    name: name,
    grade: grade,
    email: email,
    password: password,
    nis: nis
  );

  factory StudentModel.fromSnapshot(DocumentSnapshot snapshot){
    return StudentModel(
        name: snapshot.get('name'),
        grade: snapshot.get('grade'),
        email: snapshot.get('email'),
        password: snapshot.get('password'),
        nis: snapshot.get('nis'),
    );
  }

  Map<String, dynamic> toDocument(){
    return {
      'name': name,
      'grade': grade,
      'email': email,
      'password': password,
      'nis': nis
    };
  }
}