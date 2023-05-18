import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sistem_presensi/src/domain/entities/presence_entity.dart';
import 'package:sistem_presensi/src/domain/use_case/add_new_presence_usecase.dart';
import 'package:sistem_presensi/src/presentation/cubit/presence/add_presence/add_presence_state.dart';

import '../../../../../utils/geo_util.dart';
import '../../../../domain/use_case/get_current_position_usecase.dart';

class AddPresenceCubit extends Cubit<AddPresenceState> {
  final AddNewPresenceUseCase addNewPresenceUseCase;
  final GetCurrentPositionUseCase getCurrentPositionUseCase;
  // final GetPresenceUsecase getPresenceUsecase;
  AddPresenceCubit({required this.addNewPresenceUseCase, required this.getCurrentPositionUseCase}) : super(AddPresenceInitial());

  Future<void> addPresence({required PresenceEntity presence}) async {
    emit(AddPresenceLoading());
    try {
      final location = await getCurrentPositionUseCase.call();
      final geoPoint = CGeoUtil.toGeoPoint(location);
      presence.setLocation = geoPoint;

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

  // Future<void> getCurrentUserPresences() async {
  //   if(isClosed) return;
  //   emit(AddPresenceLoading());
  //   try {
  //     getPresenceUsecase.call().listen((presences) {
  //       emit(AddPresenceLoaded(presences: presences));
  //       print('from presence cubit: ${presences.where((element) => element.time?.toDate().weekday == DateTime.monday)}');
  //       // presences.forEach((element) {
  //       //   print('id: ${element.presenceId}, is_presence: ${element.isPresence}, timestamp: ${element.time}, img: ${element.imageURL}');
  //       // });
  //     });
  //   } on SocketException catch(_) {
  //     emit(AddPresenceFailure());
  //   } catch(_) {
  //     emit(AddPresenceFailure());
  //   }
  // }
}