import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app_color.dart';


mixin BaseMixin {
  void showSuccessMessage({String? title = "Success", String? message}) {
     Get.snackbar(title.toString(), message.toString(),
         snackPosition: SnackPosition.BOTTOM, backgroundColor: 
         AppColor.whiteColor, colorText: AppColor.blackColor);

  }

  void showErrorMessage({String? title = "Error", String? message}) {
    Get.snackbar(title.toString(), message.toString(),
        snackPosition: SnackPosition.BOTTOM, backgroundColor: AppColor.whiteColor, colorText: AppColor.blackColor);

  }

  void hideProgress() {
    Get.back();
  }

  void showProgress() {
    showDialog(
      context: Get.overlayContext!,
      barrierDismissible: true,
      builder: (_) => WillPopScope(
        onWillPop: () => Future.value(false),
        child: Container(
          width: 15,
          height: 15,
          child: const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
        ),
      ),
    );
  }

}
