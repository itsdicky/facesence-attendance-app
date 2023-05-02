import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../domain/entities/teacher_entity.dart';

class TeacherModel extends TeacherEntity{
  const TeacherModel({
    final String? name,
    final String? grade,
    final String? email,
    final String? password,
    final int? nip,
  }): super(
      name: name,
      grade: grade,
      email: email,
      password: password,
      nip: nip
  );

  factory TeacherModel.fromSnapshot(DocumentSnapshot snapshot){
    return TeacherModel(
      name: snapshot.get('name'),
      grade: snapshot.get('grade'),
      email: snapshot.get('email'),
      password: snapshot.get('password'),
      nip: snapshot.get('nis'),
    );
  }

  Map<String, dynamic> toDocument(){
    return {
      'name': name,
      'grade': grade,
      'email': email,
      'password': password,
      'nis': nip
    };
  }
}