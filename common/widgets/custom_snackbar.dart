import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

customSnackBar(String title, String message) {
  Get.snackbar(
    title,
    message,
    duration: const Duration(seconds: 2),
    snackPosition: SnackPosition.BOTTOM,
    margin: EdgeInsets.only(
      bottom: 20.h,
      left: 10.w,
      right: 10.w,
    ),
    titleText: Text(
      title,
      style: const TextStyle(
        fontWeight: FontWeight.w700,
      ),
    ),
    messageText: Text(
      message,
      style: const TextStyle(
        fontWeight: FontWeight.w400,
      ),
    ),
  );
}
