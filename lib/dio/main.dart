import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled_module/dio/test_provider.dart';

import 'api_client.dart';

void main() {
  ApiClient.init(
      "https://mock.apifox.com/m1/4081539-3719383-default/flutter_article/");
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomePage());
  }
}

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int curPage = 0;
  String tempValue = "";

  @override
  Widget build(BuildContext context) {
    final getResponse = ref.watch(testGetProvider);
    final getListResponse = ref.watch(testGetListProvider);
    final postResponse = ref.watch(testPostProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
          child: SingleChildScrollView(
              child: Column(
        children: [
          Row(children: [
            ElevatedButton(
              onPressed: () => ref.refresh(testGetProvider.future),
              child: const Text('testGet'),
            ),
            const SizedBox(width: 20),
            Expanded(child: Text("${getResponse.value}")),
          ]),
          const SizedBox(height: 20),
          Row(children: [
            ElevatedButton(
              onPressed: () =>
                  ref.read(testPostProvider.notifier).testPost(curPage++),
              child: const Text('testPost'),
            ),
            const SizedBox(width: 20),
            Expanded(child: Text(postResponse?.data?.toString() ?? '')),
          ]),
          const SizedBox(height: 20),
          Row(children: [
            ElevatedButton(
              onPressed: () => ref.refresh(testGetListProvider.future),
              child: const Text('testGetList'),
            ),
            const SizedBox(width: 20),
            Expanded(child: Text(getListResponse.value?.toString() ?? '')),
          ]),
        ],
      ))),
    );
  }
}
