import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyController extends GetxController {
  var count = 0.obs;

  void increment() {
    count++;
  }
}

void main() {
  Get.put(MyController()); // 创建并注册MyController实例
  runApp(const MyApp());
}

/// 💡 Obx → 不需要显式地传递控制器实例，确保已经在合适位置初始化了实例
/// class Obx extends ObxWidget {
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Obx Demo')),
        body: Center(
          child: Obx(() {
            // 💡 直接使用Get.find来获取MyController实例
            final count = Get.find<MyController>().count.value;
            return Text('点击次数: $count');
          }),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Get.find<MyController>().increment(),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

/// 💡 GetX → 可以更灵活控制其它属性，如init
/// class GetX<T extends DisposableInterface> extends StatefulWidget {
class MyAppWithGetX extends StatelessWidget {
  const MyAppWithGetX({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('GetX Demo')),
        body: Center(
          child: GetX<MyController>(
            // 可以在这里初始化MyController，如果它还没有被创建
            init: MyController(),
            builder: (controller) {
              return Text('点击次数: ${controller.count.value}');
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Get.find<MyController>().increment(),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
