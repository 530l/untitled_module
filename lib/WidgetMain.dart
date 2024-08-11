import 'package:flutter/material.dart';

void main() => runApp(
    // simple03()
    // simple04()
    simple05());

Widget simple03() {
  return Container(
    //Container(color: red)
    //所以这个 Container 充满了整个屏幕，并绘制成红色。
    //Container(width: 100, height: 100, color: red)
    //红色的 Container 想要变成 100 x 100 的大小，但是它无法变成，
    //因为屏幕强制它变成和屏幕一样的大小。
    width: 100,
    height: 100,
    color: Colors.red,
    //屏幕强制 Center 变得和屏幕一样大，所以 Center 充满了屏幕。
    //然后 Center 告诉 Container 可以变成任意大小，但是不能超出屏幕。
    //现在，Container 可以真正变成 100 × 100 大小了。
    child: Center(
      child: Container(width: 100, height: 100, color: Colors.orange),
    ),
  );
}

Widget simple04() {
  return Container(
    width: 100,
    height: 100,
    color: Colors.red,
    //与上一个样例不同的是，我们使用了 Align 而不是 Center。
    // Align 同样也告诉 Container，你可以变成任意大小。
    // 但是，如果还留有空白空间的话，它不会居中 Container。
    // 相反，它将会在允许的空间内，把 Container 放在右下角（bottomRight）。
    child: Align(
      alignment: Alignment.topCenter,
      child: Container(width: 100, height: 100, color: Colors.green),
    ),
  );
}

Widget simple05() {
  return Container(
    width: 100,
    height: 100,
    color: Colors.red,
    //屏幕强制 Center 变得和屏幕一样大，所以 Center 充满屏幕。
    // 然后 Center 告诉 Container 可以变成任意大小，
    // 但是不能超出屏幕。现在，Container 想要无限的大小，
    // 但是由于它不能比屏幕更大，所以就仅充满屏幕。
    child: Center(
      child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.yellow),
    ),
  );
}

Widget simple6() {
  return Container(
    width: 100,
    height: 100,
    color: Colors.red,
    //content_copy
      // 屏幕强制 Center 变得和屏幕一样大，所以 Center 充满屏幕。
      // 然后 Center 告诉 Container 可以变成任意大小，但是不能超出屏幕。
      // 由于 Container 没有子级而且没有固定大小，所以它决定能有多大就有多大，所以它充满了整个屏幕。
      // 但是，为什么 Container 做出了这个决定？
      // 非常简单，因为这个决定是由 Container widget 的创建者决定的。
      // 可能会因创造者而异，而且你还得阅读 Container API 文档来理解不同场景下它的行为。
    child: Center(
      child: Container(color: Colors.blue),
    )
  );
}
