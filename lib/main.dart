import 'package:flutter/material.dart';
import 'package:get/get.dart';

// 自定义 Controller 类
class CounterController extends GetxController {
  var count = 0.obs; // 使用GetX提供的obs扩展，将普通变量转换为响应式变量
  increment() => count++; // 响应式变量count的值变化会自动通知监听该变量的UI组件进行更新
}

void main() => runApp(const GetMaterialApp(home: HomePage()));

///👍 确实 简洁，不需要 StatefulWidget，也没看到 Context 的影子，接着详细看下GetX的三个主要功能~
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(context) {
    // 实例化Controller并注入到内存中
    final CounterController c = Get.put(CounterController());

    return Scaffold(
        // 使用Obx(()=>)来监听变量，当变量改变时，Obx会自动重建Widget
        appBar: AppBar(title: Obx(() => Text("Clicks: ${c.count}"))),
        // 通过Get.to()方法来导航到其他页面
        body: Center(
            child: ElevatedButton(
                child: const Text("Go to Other"),
                onPressed: () => Get.to(const OtherPage()))),
        // 点击时调用CounterController实例的increment()
        floatingActionButton: FloatingActionButton(
            onPressed: c.increment, child: const Icon(Icons.add)));
  }
}



class OtherPage extends StatelessWidget {
  const OtherPage({super.key});

  @override
  Widget build(context) {
    // 通过Get.find()来获取已经存在的Controller实例
    final CounterController c = Get.find();

    // 访问更新后的计数变量
    return Scaffold(body: Center(child: Text("${c.count}")));
  }
}

