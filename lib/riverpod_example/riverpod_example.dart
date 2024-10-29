import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:fluttercamerasample/riverpod_example/available_cameras.dart';
import 'package:fluttercamerasample/riverpod_example/camera_controller.dart';
import 'package:fluttercamerasample/riverpod_example/camera_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// カメラサンプル画面
///
/// riverpod で状態管理した実装例
class RiverpodExamplePage extends HookConsumerWidget {
  const RiverpodExamplePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cameraService = ref.watch(cameraServiceProvider);

    final lendsDirections = useAvailableCameraLendsDirections();
    final camera = lendsDirections.isNotEmpty
        ? useCameraController(lendsDirections.first)
        : null;

    void showInSnackBar(String message) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Riverpod Example'),
        actions: [
          IconButton(
            icon: const Icon(Icons.cameraswitch),
            onPressed: camera != null
                ? () async => await cameraService.toggleCamera(camera)
                : null,
          ),
        ],
      ),
      body: Center(
        child: camera == null
            ? const Text('カメラを検出できませんでした')
            : CameraPreview(camera),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: camera != null
            ? () async {
                final file = await cameraService.takePicture(camera);
                showInSnackBar('Saved picture to ${file?.path ?? ""}');
              }
            : null,
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}
