part of 'recognition_cubit.dart';

abstract class RecognitionState extends Equatable {
  const RecognitionState();
}

class RecognitionInitial extends RecognitionState {
  @override
  List<Object> get props => [];
}

class RecognitionLoading extends RecognitionState {
  @override
  List<Object> get props => [];
}

class RecognitionFailure extends RecognitionState {
  String? message;

  RecognitionFailure({this.message});

  @override
  List<Object> get props => [];
}

class RecognitionSuccess extends RecognitionState {
  List? faceArray;

  RecognitionSuccess({this.faceArray});

  @override
  List<Object> get props => [];
}
