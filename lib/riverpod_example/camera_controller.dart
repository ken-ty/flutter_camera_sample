import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// カスタムフック: useCameraController
CameraController? useCameraController(CameraLensDirection lensDirection) {
  final cameraController = useState<CameraController?>(null);

  useEffect(() {
    // カメラの初期化処理
    Future<void> initialize() async {
      final cameras = await availableCameras();
      final camera = cameras.firstWhere(
        (cam) => cam.lensDirection == lensDirection,
        orElse: () => cameras.first,
      );

      final controller = CameraController(
        camera,
        ResolutionPreset.medium,
      );

      try {
        await controller.initialize();
        cameraController.value = controller;
      } catch (e) {
        log("Camera initialization error: $e");
      }
    }

    initialize();

    // カメラの破棄処理
    return () {
      cameraController.value?.dispose();
    };
  }, [lensDirection]); // lensDirectionが変更されたときのみ再初期化

  return cameraController.value;
}
