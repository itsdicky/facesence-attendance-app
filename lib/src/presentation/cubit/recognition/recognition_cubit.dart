import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';

import '../../../../utils/ml_util/ml_service.dart';
import '../../../domain/use_case/get_face_array_usecase.dart';
import '../../../domain/use_case/store_face_array_usecase.dart';

part 'recognition_state.dart';

class RecognitionCubit extends Cubit<RecognitionState> {
  StoreFaceArrayUseCase storeFaceArrayUseCase;
  GetFaceArrayUseCase getFaceArrayUseCase;
  RecognitionCubit({required this.storeFaceArrayUseCase, required this.getFaceArrayUseCase}) : super(RecognitionInitial());

  //usecase: upload user array
  Future<void> storeFaceArray(String uid, File imageFile) async {
    emit(RecognitionLoading());
    try {
      List? faceArray = await _convertFaceArray(imageFile);
      if (faceArray != null) {
        storeFaceArrayUseCase.call(uid, faceArray);
        emit(RecognitionSuccess());
      } else {
        emit(RecognitionFailure(message: 'Wajah tidak ditemukan'));
      }
    } on FirebaseException catch(e) {
      emit(RecognitionFailure(message: e.message));
    } on SocketException catch(e) {
      emit(RecognitionFailure(message: e.message));
    } catch(_) {
      emit(RecognitionFailure());
    }
  }

  Future<List?> _convertFaceArray(File imageFile) async {
    final ml = MLService()..initialize();
    final faceArray = await ml.getFaceArray(imageFile);
    ml.close();
    return faceArray;
  }
}
