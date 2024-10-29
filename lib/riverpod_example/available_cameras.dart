import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

List<CameraLensDirection> useAvailableCameraLendsDirections() {
  final directions = useState<List<CameraLensDirection>>([]);

  useEffect(() {
    // カメラの一覧を取得
    Future<void> fetchCameras() async {
      try {
        final cameras = await availableCameras();
        directions.value = cameras.map((cam) => cam.lensDirection).toList();
      } catch (e) {
        log("Error fetching cameras: $e");
        directions.value = [];
      }
    }

    fetchCameras();

    return null;
  }, []);

  return directions.value;
}
