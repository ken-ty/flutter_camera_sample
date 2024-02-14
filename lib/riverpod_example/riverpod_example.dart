import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttercamerasample/riverpod_example/riverpod_example_provider.dart';

/// カメラサンプル画面
///
/// riverpod で状態管理した実装例
class RiverpodExamplePage extends StatelessWidget {
  const RiverpodExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const _Body(),
    );
  }
}

class _Body extends ConsumerWidget {
  const _Body();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String value = ref.watch(helloWorldProvider);

    return Center(child: Text(value));
  }
}
