import 'package:get/get_rx/src/rx_types/rx_types.dart';

import 'entitys.dart';

///使用Get的响应式编程就像使用setState一样简单。文中把 响应式/可观察变量 称为Rx，并提供了三种不同的定义方式：
// 2.2.1. 定义响应式变量的三种方式
// ① 推荐，添加.obs作为value的扩展属性

final strRx1 = "初始值".obs;
final intRx1 = 1.obs;
final boolRx1 = true.obs;
final doubleRx1 = 0.01.obs;
final listRx1 = ["字符串"].obs;
final mapRx1 = {"key": 1}.obs;
final objRx1 = User("CoderPig").obs;


// ② Rx<泛型>
final strRx2 = Rx<String>("初始值");
final intRx2 = Rx<int>(1);
final boolRx2 = Rx<bool>(true);
final doubleRx2 = Rx<double>(0.01);
final listRx2 = Rx<List<String>>(["字符串"]);
final mapRx2 = Rx<Map<String,int>>({"key": 1});
final objRx2 = Rx<User>(User("CoderPig"));

// ② Rx{Type}，不支持自定义类
final strRx3 = RxString("初始值");
final intRx3 = RxInt(1);
final boolRx3 = RxBool(true);
final doubleRx3 = RxDouble(0.01);
final listRx3 = RxList<String>(["字符串"]);
final mapRx3 = RxMap<String,int>({"key": 1});
