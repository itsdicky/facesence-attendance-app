import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'face_detection.dart';
import 'face_recognition.dart';
import 'package:image/image.dart' as imglib;

class MLService {
  final CFaceDetection faceDetection = CFaceDetection();
  final CFaceRecognition faceRecognition = CFaceRecognition();

  Future<void> initialize() async {
    faceDetection.initialize();
    await faceRecognition.initialize();
  }

  void close() {
    faceDetection.close();
    faceRecognition.close();
  }

  Future<List?> getFaceArray(File imageFile) async {
    late List? faceArray;
    await faceDetection.getFace(imageFile).then((faces) async {
      final image = await convertImageFile(imageFile);
      if (faces.isNotEmpty) {
        faceArray = await faceRecognition.getFaceArray(image, faces.first);
      } else {
        faceArray = null;
      }
    });
    return faceArray;
  }

  Future<List?> getFaceArrayFromFuture(Future<File> imageFile) async {
    final file = await imageFile;
    late List? faceArray;
    await faceDetection.getFace(file).then((faces) async {
      final image = await convertImageFile(file);
      if (faces.isNotEmpty) {
        faceArray = await faceRecognition.getFaceArray(image, faces.first);
      } else {
        faceArray = null;
      }
    });
    return faceArray;
  }

  Future<bool> predictFace(File imageFile, List faceArray) async {
    late bool isRecognized;
    await faceDetection.getFace(imageFile).then((faces) async {
      final image = await convertImageFile(imageFile);
      isRecognized = await faceRecognition.predictFace(image, faces.first, faceArray);
    });
    return isRecognized;
  }

  Future<bool> predictFaceFromFuture(Future<File> imageFile, List faceArray) async {
    final file = await imageFile;
    late bool isRecognized;
    await faceDetection.getFace(file).then((faces) async {
      final image = await convertImageFile(file);
      isRecognized = await faceRecognition.predictFace(image, faces.first, faceArray);
    });
    return isRecognized;
  }

  bool compareFaceArray(List faceArray1, List faceArray2) {
    double threshold = 0.65;
    final dist = faceRecognition.euclideanDistance(faceArray1, faceArray2);
    print('EUCLIDEAN DIST: $dist');
    if (dist <= threshold) {
      return true;
    } else {
      return false;
    }
  }

  Future<imglib.Image> convertImageFile(File imageFile) async {
    Uint8List bytes = await imageFile.readAsBytes();
    imglib.Image image = imglib.decodeImage(bytes)!;
    return image;
  }
}