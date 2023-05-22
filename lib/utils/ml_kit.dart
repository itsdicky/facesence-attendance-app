import 'dart:io';
import 'dart:ui' as ui;

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';


class CFaceDetection {
  late FaceDetector faceDetector;

  CFaceDetection() {
    //setting
    final options = FaceDetectorOptions(
      enableContours: true,
    );
    faceDetector = FaceDetector(options: options);
  }

  Future<bool> isContainFace(File imageFile) async {
    final inputImage = InputImage.fromFile(imageFile);
    final listFaces = await faceDetector.processImage(inputImage);
    return listFaces.isNotEmpty;
  }

  Future<bool> isContainFaceFromPath(String imagePath) async {
    final inputImage = InputImage.fromFilePath(imagePath);
    final listFaces = await faceDetector.processImage(inputImage);
    return listFaces.isNotEmpty;
  }

  Future<bool> isContainFaceFromFuture(Future<File> file) async {
    final imageFile = await file;
    final result = await isContainFace(imageFile);
    return result;
  }

  Future<bool> isContainFaceFromBytes(int width, int height, Uint8List imageBytes, List<Plane> planes) async {

    final ui.Size imageSize = ui.Size(width.toDouble(), height.toDouble());
    const InputImageRotation imageRotation = InputImageRotation.rotation0deg;
    const inputImageFormat = InputImageFormat.yuv_420_888;

    final planeData = planes.map(
          (Plane plane) {
        return InputImagePlaneMetadata(
          bytesPerRow: plane.bytesPerRow,
          height: plane.height,
          width: plane.width,
        );
      },
    ).toList();

    final inputImageData = InputImageData(
      size: imageSize,
      imageRotation: imageRotation,
      inputImageFormat: inputImageFormat,
      planeData: planeData,
    );

    final inputImage = InputImage.fromBytes(
      bytes: imageBytes,
      inputImageData: inputImageData,
    );

    final listFaces = await faceDetector.processImage(inputImage);
    return listFaces.isNotEmpty;
  }

  Future<bool> processFromCameraImage(CameraImage cameraImage) async {
    final WriteBuffer allBytes = WriteBuffer();
    for (final Plane plane in cameraImage.planes) {
      allBytes.putUint8List(plane.bytes);
    }
    final bytes = allBytes.done().buffer.asUint8List();

    final imgFile = File.fromRawPath(bytes);
    final ui.Size imageSize = ui.Size(cameraImage.width.toDouble(), cameraImage.height.toDouble());
    const InputImageRotation imageRotation = InputImageRotation.rotation0deg;
    final inputImageFormat = InputImageFormatValue.fromRawValue(cameraImage.format.raw) ?? InputImageFormat.nv21;
    // const inputImageFormat = InputImageFormat.yuv_420_888;

    final planeData = cameraImage.planes.map(
          (Plane plane) {
        return InputImagePlaneMetadata(
          bytesPerRow: plane.bytesPerRow,
          height: plane.height,
          width: plane.width,
        );
      },
    ).toList();

    final inputImageData = InputImageData(
      size: imageSize,
      imageRotation: imageRotation,
      inputImageFormat: inputImageFormat,
      planeData: planeData,
    );

    // final inputImage = InputImage.fromBytes(bytes: bytes, inputImageData: inputImageData);
    final inputImage = InputImage.fromFile(imgFile);

    final listFaces = await faceDetector.processImage(inputImage);
    return listFaces.isNotEmpty;
  }

  Future<void> close() async {
    await faceDetector.close();
  }
}