import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

abstract class AddPresenceState extends Equatable {
  const AddPresenceState();
}

class AddPresenceInitial extends AddPresenceState {
  @override
  List<Object> get props => [];
}

class AddPresencePreview extends AddPresenceState {
  final Timestamp timestamp;
  final GeoPoint geoPoint;
  final String dateTimeString;
  final File image;

  const AddPresencePreview({required this.timestamp, required this.geoPoint, required this.dateTimeString, required this.image});

  @override
  List<Object> get props => [];
}

class AddPresenceLoading extends AddPresenceState {
  @override
  List<Object> get props => [];
}

class AddPresenceSuccess extends AddPresenceState {
  @override
  List<Object> get props => [];
}

class AddPresenceFailure extends AddPresenceState {
  final String? message;

  const AddPresenceFailure({this.message});

  @override
  List<Object> get props => [];
}