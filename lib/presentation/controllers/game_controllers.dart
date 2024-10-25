import 'package:get/get.dart';
import 'package:flutter/material.dart';

class GameController extends GetxController {
  RxDouble appBarHeight = kToolbarHeight.obs;
  RxBool isTaskComplete = false.obs;

  void toggleAppBarHeight(double enlargedAppBar) {
    appBarHeight.value =
        appBarHeight.value == kToolbarHeight ? enlargedAppBar : kToolbarHeight;
  }

  void completeTask(double targetY, Function moveOutOfAppBar) {
    moveOutOfAppBar(targetY - 250);
    isTaskComplete.value = true;
  }
}
