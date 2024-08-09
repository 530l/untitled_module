import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'myGetxController.dart';

void main() => runApp(const GetMaterialApp(home: HomePage()));

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(context) {
    //全局的。
    Get.put(MainController());
    //局部的
    var count = 0.obs;

    var flag = 0;

    MainController mainController = Get.find();

    ///在视图中，当我们想改变一个特定的Widget时，我们通常有很多Flutter方式的模板。 有了GetX，你也可以忘记这些模板代码了。
    /// StreamBuilder( ... )? initialValue: ...? builder: ...? 不，你只需要把这个变量放在Obx()这个Widget里面就可以了。
    /// 你只需记住 Obx(()=>
    /// Obx是相当聪明的，只有当controller.name的值发生变化时才会改变。
    return Scaffold(
        appBar: AppBar(title: Obx(() => Text("Clicks: ${count.value}"))),
        body: Column(
          children: [
            Text("flag1: $flag"),

            ///响应式组件-Obx Widget & GetX Widget
            Obx(() => Text("flag222: ${mainController.count1.value}")),
            GetX<MainController>(
              builder: (controller) {
                print("count 1 rebuild");
                return Text('${controller.count1.value}');
              },
            ),

            ///更精细的更新控制-GetBuilder
            ///允许开发者在 不依赖响应式变量 的情况下，手动控制何时更新UI。
            ///适用于状态变化不频繁或不需要全局监听的场景，
            ///通过调用Controller中的 update() ，可以精确控制哪个 GetBuilder 组件需要重建。
            // 不需要使用 ChangeNotifier 和 StatefulWidget，
            // 提供了 initState 和 dispose 属性，允许你在Widget初始化和销毁时执行相关操作。
            // 内部通过存储 创建者ID 来更新小部件，低内存消耗，
            // 即便是大量的GetBuilder实例也不会对性能造成影响。
            GetBuilder<CartController>(
                init: CartController(),
                builder: (cartController) {
                  return Column(
                    children: [
                      Text("商品数量: ${cartController.itemCount}"),
                      Text("总价: ${cartController.totalPrice}"),
                      ElevatedButton(
                        onPressed: () => cartController.addItem(10.0),
                        child: Text("添加商品"),
                      ),
                      ElevatedButton(
                        onPressed: () => cartController.removeItem(10.0),
                        child: Text("移除商品"),
                      ),
                    ],
                  );
                },
                dispose: (cartController) {}),

            ///局部状态组件-ObxValue & ValueBuilder
            ObxValue(
                // 构造子Widget的函数
                (data) => Switch(
                    value: data.value, onChanged: (flag) => data.value = flag),
                // 要监听的Rx变量
                false.obs),

          ],
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              count++;
              mainController.count1.value++;
              flag = mainController.count1.value;
            },
            child: const Icon(Icons.add)));
  }
}
