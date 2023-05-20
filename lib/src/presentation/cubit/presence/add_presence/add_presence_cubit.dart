import 'dart:io';

import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sistem_presensi/src/domain/entities/presence_entity.dart';
import 'package:sistem_presensi/src/domain/use_case/add_new_presence_usecase.dart';
import 'package:sistem_presensi/src/presentation/cubit/presence/add_presence/add_presence_state.dart';

import '../../../../../utils/date_util.dart';
import '../../../../../utils/geo_util.dart';
import '../../../../domain/use_case/get_current_position_usecase.dart';

class AddPresenceCubit extends Cubit<AddPresenceState> {
  final AddNewPresenceUseCase addNewPresenceUseCase;
  final GetCurrentPositionUseCase getCurrentPositionUseCase;

  AddPresenceCubit({required this.addNewPresenceUseCase, required this.getCurrentPositionUseCase}) : super(AddPresenceInitial());

  Future<void> addPresence({required PresenceEntity presence}) async {
    emit(AddPresenceLoading());
    try {
      await addNewPresenceUseCase.call(presence);
      emit(AddPresenceSuccess());
    } on FirebaseException catch(e){
      emit(AddPresenceFailure(message: e.message));
    } on SocketException catch(e) {
      emit(AddPresenceFailure(message: e.message));
    } catch(_) {
      emit(const AddPresenceFailure());
    }
  }

  Future<void> capturePresenceSnapshot({required Future<XFile> image}) async {
    emit(AddPresenceLoading());
    try {
      Future.wait([getCurrentPositionUseCase.call(), image]).then((List responses) {
        final xfile = responses[1] as XFile;
        emit(AddPresencePreview(
          timestamp: Timestamp.fromDate(responses[0].timestamp!),
          geoPoint: CGeoUtil.toGeoPoint(responses[0]),
          dateTimeString: CDateUtil.getFormattedDateTimeStringWIB(responses[0].timestamp!),
          image: File(xfile.path),
        ));
      });
    } on SocketException catch(e) {
      emit(AddPresenceFailure(message: e.message));
    } catch(_) {
      emit(const AddPresenceFailure());
    }
  }
}