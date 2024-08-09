import 'package:get/get.dart';

class MainController extends GetxController {
  var count1 = 0.obs;

  @override
  void onClose() {
    count1.close();
    super.onClose();
  }
}


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
