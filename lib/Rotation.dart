import 'dart:io';
import 'package:exif/exif.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;

Future<File> fixExifRotation(String imagePath) async {
  print('Rotating image necessary');
  final originalFile = File(imagePath);
  List<int> imageBytes = await originalFile.readAsBytes();
  final originalImage = await decodeDownloadedImage(imageBytes);
  final height = originalImage.height;
  final width = originalImage.width;
  // We'll use the exif package to read exif data
  // This is map of several exif properties
  // Let's check 'Image Orientation'
  //final exifData = await readExifFromBytes(imageBytes);
  img.Image fixedImage;

  // Let's check for the image size
  if (height <= width) {
    print("height < width");
    // I'm interested in portrait photos so
    // I'll just return here
    return originalFile;
  }else{
    print("height > width");
    // rotate
    // if (exifData['Image Orientation'].printable.contains('Horizontal')) {
    //   fixedImage = img.copyRotate(originalImage, 90);
    // } else if (exifData['Image Orientation'].printable.contains('180')) {
    //   fixedImage = img.copyRotate(originalImage, -90);
    // } else {
    //   fixedImage = img.copyRotate(originalImage, 0);
    // }
    fixedImage = await compute(copyRotate,originalImage);

    print("Image rotated");

    // Here you can select whether you'd like to save it as png
    // or jpg with some compression
    // I choose jpg with 100% quality
    final fixedFile = await originalFile.writeAsBytes(await compute(img.encodeJpg,fixedImage));
    print("byte written");

    return fixedFile;
  }
}
Future<img.Image> copyRotate(var originalImage)async{
  return img.copyRotate(originalImage, 90);
}
Future<img.Image> decodeDownloadedImage(List<int> imageBytes)async{
  return await compute(img.decodeImage,imageBytes);
}