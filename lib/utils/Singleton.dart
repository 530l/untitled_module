class Singleton {
  // ① 私有构造函数
  Singleton._internal();

  // ② 定义静态私有实例
  static Singleton? _instance = Singleton._internal();

  // ③ 定义获取实例的静态方法，也可以用factory构造函数来创建
  static Singleton get instance => _instance ??= Singleton._internal();

  // 添加需要的变量或方法
  int _counter = 0;

  void incrementCounter() {
    _counter++;
  }

  int get counter => _counter;
}


void main() {
  var s1 = Singleton.instance;
  var s2 = Singleton.instance;
  print(identical(s1, s2)); // 输出：true，表示两个完全相等的对象
  s1.incrementCounter();
  print(s2.counter);  // 输出：1
}
