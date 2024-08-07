import 'package:flutter/cupertino.dart';

///  Widget 和 Element 的对应关系
///  widget 的定义就是 对一个 Element 配置的描述，也就是说，widget 只是一个配置的描述，并不是真正的渲染对象，
///  就相当于是 Android 里面的 xml，只是描述了一下属性，但他并不是真正的 View。
///  并且通过查看源码可知 widget 中有一个 createElement 方法，用来创建 Element。
///
///  在 Flutter 中，Key 的主要作用是帮助框架在重建 Widget 树时保持和正确分配状态。
///  通过为 Widget 提供唯一标识符，Key 确保了在布局发生变化时，
///  Widget 的状态不会丢失，从而提升应用的性能和用户体验。
///  在实际开发中，合理使用 Key 可以显著改善复杂 UI 交互的管理和维护。
//

class MyBox extends StatefulWidget {

  final Color color;

  MyBox(this.color, {required Key key}) : super(key: key);

  //在这个示例中 flutter 不能通过 Container 的颜色来设置标识，所以就没办法确定那个到底是哪个，
  // 所以我们需要一个类似于 id 的东西，给每个 widget 一个标识，而 key 就是这个标识。
  // MyBox(this.color);

  @override
  _BoxState createState() => _BoxState();
}

class _BoxState extends State<MyBox> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
          width: 100,
          height: 100,
          //todo state通过widget属性访问外面的属性
          //在这个示例中 flutter 不能通过 Container 的颜色来设置标识，所以就没办法确定那个到底是哪个，
          // 所以我们需要一个类似于 id 的东西，给每个 widget 一个标识，而 key 就是这个标识。
          color: widget.color,
          alignment: Alignment.center,
          child: Text(_count.toString(), style: const TextStyle(fontSize: 30))),
      onTap: () => setState(() => ++_count),
    );
  }
}

/// flutter butild 方法中的 BuildContext 具体是什么东西
// 在 Flutter 中，BuildContext 表示了当前 Widget 在树中的位置和上下文信息。
// 它提供了与当前 Widget 相关的信息，如父级 Widget、Theme、MediaQuery、Navigator 等，
// 以便在构建 UI 时使用。BuildContext 实际上是一个指向当前 Widget 在 Widget 树中位置的引用。
// [BuildContext] 对象实际上是 [Element] 对象。 [BuildContext] 接口用于阻止直接操作 [Element] 对象。
// BuildContext 的作用
// 定位位置：BuildContext 可以告诉你当前 Widget 在 Widget 树中的位置，如父级 Widget 是什么、祖先 Widget 是什么等。
// 获取相关信息：通过 BuildContext 可以获取当前 Widget 上下文相关的信息，如主题、设备信息、国际化信息等。
// 构建 UI：在构建 Widget 时，通常需要使用 BuildContext 来访问上下文信息，例如使用 Theme.of(context) 获取当前主题。
///使用 BuildContext
//BuildContext 主要用于构建 UI 和管理状态，在 Widget 的 build 方法中通常会传入 BuildContext 参数。
//以下是一些常见的使用场景：
//获取当前主题：
//@override
// Widget build(BuildContext context) {
//   final theme = Theme.of(context);
//   return Container(
//     color: theme.backgroundColor,
//     child: Text('Hello', style: theme.textTheme.bodyText1),
//   );
// }
//查找父级 Widget：
//@override
// Widget build(BuildContext context) {
//   final parentWidget = context.widget;
//   return Container();
// }
//获取设备信息：
//@override
// Widget build(BuildContext context) {
//   final mediaQuery = MediaQuery.of(context);
//   final size = mediaQuery.size;
//   final orientation = mediaQuery.orientation;
//   return Container();
// }
//导航到新页面：
//Navigator.push(
//   context,
//   MaterialPageRoute(builder: (context) => SecondScreen()),
// );
///注意事项
// BuildContext 可以在 Widget 树的任何位置使用，但需要注意使用范围，避免在不合适的位置使用造成不必要的性能开销。
// 尽管 BuildContext 是一个抽象类，但通常使用的是 BuildContext 的子类 Element，它表示了在 Render 树中的一个节点。
// BuildContext 是 Flutter 中非常重要且常用的概念，理解它的作用和使用方法对于构建复杂的 UI 和管理状态至关重要。


///什么是flutter里的key? 有什么用？
//在 Flutter 中，Key 是一个非常重要的概念，主要用于维护和优化 Widget 树的状态。
//Key 在 Flutter 中有多种类型，但它们的主要用途是提供一个标识符，以便 Flutter 可以正确地重建和复用 Widget 树中的各个部分。
// 以下是 Key 的详细介绍及其作用：
// Key 的作用
/// 保持状态：
// 当你在 Widget 树中重构布局或者插入/删除 Widget 时，
// Key 可以帮助 Flutter 保持某些 Widget 的状态。没有 Key，Flutter 可能会错误地将状态分配给错误的 Widget。
/// 优化性能：
// 通过使用 Key，Flutter 可以更高效地进行 Widget 树的比较和更新，从而避免不必要的重建。
/// 唯一标识：
// Key 可以为 Widget 提供一个唯一标识，使得 Flutter 能够在重建 Widget 树时正确地识别和定位这些 Widget。

