import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class CartController extends GetxController {
  var itemCount = 0;
  var totalPrice = 0.0;

  void addItem(double price) {
    itemCount++;
    totalPrice += price;
    update(); // 通知 GetBuilder 更新 UI
  }

  void removeItem(double price) {
    if (itemCount > 0) {
      itemCount--;
      totalPrice -= price;
      update(); // 通知 GetBuilder 更新 UI
    }
  }
}

void main() {
  runApp(const MyApp());
}

///允许开发者在 不依赖响应式变量 的情况下，手动控制何时更新UI。适用于状态变化不频繁或不需要全局监听的场景，
///通过调用Controller中的 update() ，可以精确控制哪个 GetBuilder 组件需要重建。
// 不需要使用 ChangeNotifier 和 StatefulWidget，提供了 initState 和 dispose 属性，
// 允许你在Widget初始化和销毁时执行相关操作。内部通过存储 创建者ID 来更新小部件，低内存消耗，
// 即便是大量的GetBuilder实例也不会对性能造成影响。😄
// 写个简单的用户增删商品时更新总价和数量的代码示例：
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Obx Demo')),
        body: GetBuilder<CartController>(
          init: CartController(),
          builder: (cartController) {
            return Column(
              children: [
                Text("商品数量: ${cartController.itemCount}"),
                Text("总价: ${cartController.totalPrice}"),
                ElevatedButton(
                  onPressed: () => cartController.addItem(10.0),
                  child: const Text("添加商品"),
                ),
                ElevatedButton(
                  onPressed: () => cartController.removeItem(10.0),
                  child: const Text("移除商品"),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
