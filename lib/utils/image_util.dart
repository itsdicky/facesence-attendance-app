import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:ffi/ffi.dart';
import 'package:image/image.dart' as imglib;

typedef convert_func = Pointer<Uint32> Function(
    Pointer<Uint8>, Pointer<Uint8>, Pointer<Uint8>,
    Int32, Int32, Int32, Int32
    );

typedef Convert = Pointer<Uint32> Function(
    Pointer<Uint8>, Pointer<Uint8>, Pointer<Uint8>,
    int, int, int, int
    );

//utility for calls C function to convert YUV420_888 to RGB
class CConvertImage {
  static final DynamicLibrary _convertImageLib = Platform.isAndroid
      ? DynamicLibrary.open("libconvertImage.so")
      : DynamicLibrary.process();

  static late Convert conv;

  static void init() {
    conv = _convertImageLib
      .lookup<NativeFunction<convert_func>>('convertImage')
      .asFunction<Convert>();
  }

  static imglib.Image convertToRGB(CameraImage cameraImage) {
    // Allocate memory for the 3 planes of the image
    Pointer<Uint8> p = malloc.allocate(cameraImage.planes[0].bytes.length);
    Pointer<Uint8> p1 = malloc.allocate(cameraImage.planes[1].bytes.length);
    Pointer<Uint8> p2 = malloc.allocate(cameraImage.planes[2].bytes.length);

    // Assign the planes data to the pointers of the image
    Uint8List pointerList = p.asTypedList(cameraImage.planes[0].bytes.length);
    Uint8List pointerList1 = p1.asTypedList(cameraImage.planes[1].bytes.length);
    Uint8List pointerList2 = p2.asTypedList(cameraImage.planes[2].bytes.length);
    pointerList.setRange(0, cameraImage.planes[0].bytes.length, cameraImage.planes[0].bytes);
    pointerList1.setRange(0, cameraImage.planes[1].bytes.length, cameraImage.planes[1].bytes);
    pointerList2.setRange(0, cameraImage.planes[2].bytes.length, cameraImage.planes[2].bytes);

    // Call the convertImage function and convert the YUV to RGB
    Pointer<Uint32> imgP = conv(p, p1, p2, cameraImage.planes[1].bytesPerRow,
        cameraImage.planes[1].bytesPerPixel!, cameraImage.width, cameraImage.height);

    // Get the pointer of the data returned from the function to a List
    Uint32List imgData = imgP.asTypedList((cameraImage.width * cameraImage.height));

    // Generate image from the converted data
    imglib.Image img = imglib.Image.fromBytes(height: cameraImage.height, width: cameraImage.width, bytes: imgData.buffer);

    // Free the memory space allocated
    // from the planes and the converted data
    malloc.free(p);
    malloc.free(p1);
    malloc.free(p2);
    malloc.free(imgP);

    return img;
  }
}


//OTHER EXPERIMENTAL FUNCTION

const shift = (0xFF << 24);
Future<imglib.Image?> convertYUV420toImageColor(CameraImage image) async {
  try {
    final int width = image.width;
    final int height = image.height;
    final int uvRowStride = image.planes[1].bytesPerRow;
    final int uvPixelStride = image.planes[1].bytesPerPixel!;

    print("uvRowStride: " + uvRowStride.toString());
    print("uvPixelStride: " + uvPixelStride.toString());

    // imgLib -> Image package from https://pub.dartlang.org/packages/image
    var img = imglib.Image(width: width, height: height);

    // Fill image buffer with plane[0] from YUV420_888
    for (int x = 0; x < width; x++) {
      for (int y = 0; y < height; y++) {
        final int uvIndex = uvPixelStride * (x / 2).floor() + uvRowStride * (y / 2).floor();
        final int index = y * width + x;

        final yp = image.planes[0].bytes[index];
        final up = image.planes[1].bytes[uvIndex];
        final vp = image.planes[2].bytes[uvIndex];
        // Calculate pixel color
        int r = (yp + vp * 1436 / 1024 - 179).round().clamp(0, 255);
        int g = (yp - up * 46549 / 131072 + 44 - vp * 93604 / 131072 + 91).round().clamp(0, 255);
        int b = (yp + up * 1814 / 1024 - 227).round().clamp(0, 255);
        // color: 0x FF  FF  FF  FF
        //           A   B   G   R
        img.data?.toUint8List()[index] = shift | (b << 16) | (g << 8) | r;
      }
    }

    imglib.PngEncoder pngEncoder = imglib.PngEncoder(level: 0, filter: imglib.PngFilter.none);
    Uint8List png = pngEncoder.encode(img);
    // muteYUVProcessing = false;
    return imglib.Image.fromBytes(width: width, height: height, bytes: png.buffer);
  } catch (e) {
    print(">>>>>>>>>>>> ERROR:" + e.toString());
  }
  return null;
}

Future<Uint8List?> convertImagetoPng(CameraImage image) async {
  late imglib.Image img;

  try {
    if (image.format.group == ImageFormatGroup.yuv420) {
      img = convertYUV420(image);
    } else if (image.format.group == ImageFormatGroup.bgra8888) {
      img = convertBGRA8888(image);
    }

    imglib.PngEncoder pngEncoder = new imglib.PngEncoder();

    // Convert to png
    Uint8List png = pngEncoder.encode(img);
    return png;
  } catch (e) {
    print(">>>>>>>>>>>> ERROR:" + e.toString());
  }
  return null;
}

// CameraImage BGRA8888 -> PNG
// Color
imglib.Image convertBGRA8888(CameraImage image) {
  return imglib.Image.fromBytes(
    width: image.width,
    height: image.height,
    bytes: image.planes[0].bytes.buffer,
  );
}

// CameraImage YUV420_888 -> PNG -> Image (compresion:0, filter: none)
// Black
imglib.Image convertYUV420(CameraImage image) {
  var img = imglib.Image(width: image.width, height: image.height); // Create Image buffer

  Plane plane = image.planes[0];
  const int shift = (0xFF << 24);

  // Fill image buffer with plane[0] from YUV420_888
  for (int x = 0; x < image.width; x++) {
    for (int planeOffset = 0;
    planeOffset < image.height * image.width;
    planeOffset += image.width) {
      final pixelColor = plane.bytes[planeOffset + x];
      // color: 0x FF  FF  FF  FF
      //           A   B   G   R
      // Calculate pixel color
      var newVal = shift | (pixelColor << 16) | (pixelColor << 8) | pixelColor;

      // img.data![planeOffset + x] = newVal;
      img.data?.toUint8List()[planeOffset + x] = newVal;
    }
  }

  return img;
}