import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cameraServiceProvider = Provider((ref) => CameraService());

class CameraService {
  /// カメラの切り替え
  ///
  /// [camera] を別の向きのレンズに切り替える。
  Future<void> toggleCamera(CameraController? camera) async {
    final cameras = await availableCameras();
    final cams = [
      cameras.firstWhereOrNull(
          (cam) => cam.lensDirection == CameraLensDirection.front),
      cameras.firstWhereOrNull(
          (cam) => cam.lensDirection == CameraLensDirection.back),
      cameras.firstWhereOrNull(
          (cam) => cam.lensDirection == CameraLensDirection.external),
    ].whereNotNull().toList();

    final currentIndex = camera != null ? cams.indexOf(camera.description) : -1;
    camera?.setDescription(cams[(currentIndex + 1) % cams.length]);
  }

  /// 写真を撮影する
  ///
  /// [camera] で写真を撮影する。
  /// 写真が撮影できなかった場合は `null` を返す。
  /// 撮影した写真は `XFile` で返される。
  Future<XFile?> takePicture(CameraController camera) async {
    try {
      final file = await camera.takePicture();
      return file;
    } on CameraException catch (e) {
      log('Camera Exception: $e');
      return null;
    }
  }
}
