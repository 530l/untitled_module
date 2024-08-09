import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() => runApp(GetMaterialApp(
      ///根路由不能是/  换成 /xxxxxx,否则unknownRoute不生效
      initialRoute: '/first',
      getPages: [
        GetPage(name: '/first', page: () => const First()),
        GetPage(name: '/second', page: () => const Second()),
        GetPage(name: '/third', page: () => const Third()),
      ],
      unknownRoute:
          GetPage(name: '/notfound', page: () => const UnknownRoutePage()),
    ));

class First extends StatelessWidget {
  const First({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            Get.snackbar("hi", "i am a modern snackbar");
          },
        ),
        title: const Text('First Route'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Open route'),
          onPressed: () {
            // 跳转页面传参, dynamic arguments,
            var gifts = <String, String>{};
            gifts['first'] = 'partridge';
            gifts['second'] = 'turtledoves';
            gifts['fifth'] = 'golden rings';
            Get.toNamed("/second", arguments: gifts);
            // Get.toNamed("/second");

          },
        ),
      ),
    );
  }
}

class Second extends StatelessWidget {
  const Second({super.key});


  @override
  Widget build(BuildContext context) {
    // 新页面获取传递过来的参数
    print(Get.arguments);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            Get.snackbar("hi", "i am a modern snackbar");
          },
        ),
        title: const Text('second Route'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Open route'),
          onPressed: () {
            Get.toNamed("/third");
          },
        ),
      ),
    );
  }
}

class Third extends StatelessWidget {
  const Third({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Third Route"),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Go UnknownRoutePage!'),
          onPressed: () {
            Get.toNamed("12313");
          },
        ),
      ),
    );
  }
}

class UnknownRoutePage extends StatelessWidget {
  const UnknownRoutePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("UnknownRoutePage"),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Go back!'),
          onPressed: () {
            Get.back();
          },
        ),
      ),
    );
  }
}
