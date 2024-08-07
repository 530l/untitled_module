Future<void> fetchData() async {
  /// async：标记一个函数为异步函数。异步函数可以包含 await 表达式，等待异步操作的结果。
  /// await：用于暂停异步函数的执行，直到 Future 完成并返回结果。
  print('Fetching data...');
  await Future.delayed(const Duration(seconds: 2)); // 模拟网络请求
  print('Data fetched');
}

Future<String> fetchUsername() async {
  ///Future
  // 定义：表示一个异步操作的结果，这个结果在将来的某个时刻会返回。
  // 特点：Future 只能完成一次，返回一个单一的结果或错误。
  // 用法：常用于网络请求、文件读取等一次性操作。
  await Future.delayed(const Duration(seconds: 1));
  return 'User123';
}

Stream<int> numberStream() async* {
  ///Stream
  // 定义：表示一系列异步数据的序列，可以是多个值或错误。
  // 特点：Stream 可以多次发出数据，类似于异步的数据流。
  // 用法：常用于需要多次更新的数据，如实时数据流、用户输入事件等。
  for (int i = 1; i <= 5; i++) {
    await Future.delayed(const Duration(seconds: 1));
    yield i;
  }
}

///

/// 在 Flutter 中，async 和 await 是用于处理异步操作的关键字，
/// 而 Future 和 Stream 是处理异步数据的主要机制。
void main() async {
  ///fetchData 函数会等待两秒钟后打印 "Data fetched"，而 "Other operations" 会立即打印，因为 fetchData 是异步的。
  fetchData();
  print('Other operations');

  String username = await fetchUsername();
  print(username);

  numberStream().listen((number) {
    print(number);
  });
}

///总结
//
// async 和 await：用于简化异步操作的处理，使代码看起来像同步代码。
// Future：表示一次性异步操作的结果，完成后返回单一结果。
// Stream：表示多个异步数据序列，支持多次数据更新。
//
// 理解 async、await、Future 和 Stream 可以帮助你更好地处理 Flutter 应用中的异步编程任务。

//在 Dart 和 Flutter 中，async 和 await 的设计目的是简化异步编程，
// 它们并不会阻塞主线程或阻止其他代码的执行。理解它们的工作原理可以帮助你更好地处理异步操作。下面是详细解释：
//async 和 await 的工作原理
// async 函数： 标记一个函数为异步函数，表示该函数内部可以包含异步操作。
// await 关键字： 用于暂停异步函数的执行，直到 Future 完成并返回结果。await 关键字只能在 async 函数中使用。

///异步执行
// 当调用一个 async 函数时，该函数会立即返回一个 Future 对象，并继续执行后续代码，而不会阻塞主线程。
// await 关键字会暂停 async 函数内的执行，等待异步操作完成，但其他同步代码仍然会继续执行。

///总结
//
// async 函数：立即返回一个 Future 对象，不会阻塞主线程。
// await 关键字：暂停 async 函数的执行，等待 Future 完成，但不会阻塞其他代码的执行。
// 其他代码：在等待异步操作完成时，其他同步代码会继续执行，不会被阻塞。
//
// 这种机制使得 Dart 能够高效地处理异步操作，保持应用的响应性。理解这一点对于编写流畅、高性能的 Flutter 应用非常重要。
