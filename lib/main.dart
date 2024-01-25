import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttercamerasample/camera_example/camera_example.dart';
import 'package:fluttercamerasample/riverpod_example/riverpod_example.dart';
import 'package:fluttercamerasample/video_player_example/video_player_example.dart';
import 'package:package_info_plus/package_info_plus.dart';

const _logPrefix = 'main.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // このアプリについて
  final packageInfo = await PackageInfo.fromPlatform();
  log('$_logPrefix ${packageInfo.appName} ${packageInfo.version} (${packageInfo.buildNumber}) launched!');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Camera Sample',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0x00C5E0EB)),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

/// ホーム画面
///
/// 各サンプルへ遷移できる
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('Flutter Camera Sample'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: [_aboutButton(context)],
      ),
      body: const _Body(),
    );
  }

  /// アプリについてのダイアログを表示する
  Widget _aboutButton(BuildContext context) {
    return IconButton(
      onPressed: () => showAboutDialog(
        context: context,
        applicationIcon: const FlutterLogo(),
        applicationLegalese: '© 2024 CYKAMI.com',
        children: const [
          Text(
            'Flutter Camera Sample は、Flutter でカメラを使うサンプルです。'
            '公式サンプル 及び riverpod を用いたデモ画面を提供します。',
          ),
        ],
      ),
      icon: const Icon(Icons.question_mark),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
        child: Column(
          children: [
            _customButton(
              title: 'camera デモ画面',
              icon: Icons.camera_alt,
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CameraExamplePage(),
                ),
              ),
            ),
            _customButton(
              title: 'video_player デモ画面',
              icon: Icons.video_call,
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const VideoPlayerExamplePage(),
                ),
              ),
            ),
            _customButton(
              title: 'riverpod を使った実装例',
              icon: Icons.air,
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const RiverpodExamplePage(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _customButton({
    required String title,
    IconData? icon,
    void Function()? onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Row(
        children: [
          Icon(icon ?? Icons.open_in_new),
          const SizedBox(width: 8),
          Text(title),
        ],
      ),
    );
  }
}
