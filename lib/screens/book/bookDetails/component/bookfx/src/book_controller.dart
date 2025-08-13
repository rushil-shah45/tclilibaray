import 'package:get/get.dart';

class BookController extends GetxController {
  int nextType = 0;
  int currentIndex = 0; // 当前页
  int goToIndex = 0; // 跳转页

  /// 上一页
  last() {
    nextType = -1;
    update();
  }

  /// 下一页
  next() {
    nextType = 1;
    update();
  }

  // 跳页
  goTo(int index) {
    nextType = 0;
    goToIndex = index;
    update();
  }
}
