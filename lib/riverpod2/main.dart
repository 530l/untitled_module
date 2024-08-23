import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

///一个不可变的Provider。只能读，不能写。
final provider = Provider((ref) => 'Hello, Riverpod!');

///可变的
enum ProductSortType {
  name,
  price,
}

final productSortTypeProvider = StateProvider<ProductSortType>((ref) => ProductSortType.name,);

@riverpod
void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final message = ref.watch(provider);
    // 2. 使用 ref.watch 或 ref.read 来访问 stateProvider 的状态
    final productSort = ref.watch(productSortTypeProvider);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Riverpod Example'),
        ),
        body: Center(
          child: Row(children: [
            Text(message), Text(productSort.name)
          ],),
        ),
        floatingActionButton: ElevatedButton(
          onPressed: () {
          },
          child: const Text('改变内容，点我'),
        ),
      ),
    );
  }
}
