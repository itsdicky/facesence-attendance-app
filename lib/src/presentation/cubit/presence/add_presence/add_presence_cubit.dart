import 'dart:io';

import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sistem_presensi/constant/app_config.dart';
import 'package:sistem_presensi/src/domain/entities/presence_entity.dart';
import 'package:sistem_presensi/src/domain/use_case/add_new_presence_usecase.dart';
import 'package:sistem_presensi/src/presentation/cubit/presence/add_presence/add_presence_state.dart';
import 'package:sistem_presensi/utils/ml_util/ml_service.dart';

import '../../../../../utils/date_util.dart';
import '../../../../../utils/geo_util.dart';
import '../../../../domain/use_case/get_current_position_usecase.dart';
import '../../../../domain/use_case/get_face_array_usecase.dart';

class AddPresenceCubit extends Cubit<AddPresenceState> {
  final AddNewPresenceUseCase addNewPresenceUseCase;
  final GetCurrentPositionUseCase getCurrentPositionUseCase;
  final GetFaceArrayUseCase getFaceArrayUseCase;

  AddPresenceCubit({required this.addNewPresenceUseCase, required this.getCurrentPositionUseCase, required this.getFaceArrayUseCase}) : super(AddPresenceInitial());

  Future<void> addPresence({required PresenceEntity presence}) async {
    emit(AddPresenceLoading());
    try {
      await addNewPresenceUseCase.call(presence);
      emit(AddPresenceSuccess());
    } on FirebaseException catch(e){
      print(e.code);
      emit(AddPresenceFailure(message: e.message));
    } on SocketException catch(e) {
      print('Error Socket');
      emit(AddPresenceFailure(message: e.message));
    } catch(_) {
      print('Error');
      emit(const AddPresenceFailure());
    }
  }

  Future<void> capturePresenceSnapshot({required Future<XFile> image}) async {
    emit(AddPresenceLoading());
    final ml = MLService()..initialize();
    Future<File> file = image.then((image) => File(image.path)); //convert to Future file

    try {
      //get current position, get faceArr from database, and convert file image to faceArr
      Future.wait([getCurrentPositionUseCase.call(), file, getFaceArrayUseCase.call(), ml.getFaceArrayFromFuture(file)]).then((List responses) {
        final location = CGeoUtil.toGeoPoint(responses[0]);
        final validLocation = CGeoUtil.isInsideArea(
          location,
          GeoPoint(AppConfig.validLoc['lat']!, AppConfig.validLoc['lng']!),
          AppConfig.presenceRadius,
        );

        if (!validLocation) {
          emit(AddPresenceFailure(message: 'Lokasi diluar jangkauan'));
          return;
        }

        if (responses[3] != null) {
          if(ml.compareFaceArray(responses[2], responses[3])){
            emit(AddPresencePreview(
              timestamp: Timestamp.fromDate(responses[0].timestamp!),
              geoPoint: location,
              dateTimeString: CDateUtil.getFormattedDateTimeStringWIB(responses[0].timestamp!),
              image: responses[1],
            ));
          } else {
            emit(AddPresenceFailure(message: 'Wajah tidak cocok'));
          }
        } else {
          emit(AddPresenceFailure(message: 'Wajah tidak terdeteksi'));
        }
      });
    } on SocketException catch(e) {
      emit(AddPresenceFailure(message: e.message));
    } catch(_) {
      emit(const AddPresenceFailure());
    } finally {
      ml.close();
    }
  }
}