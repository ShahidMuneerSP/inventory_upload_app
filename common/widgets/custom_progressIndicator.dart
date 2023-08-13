import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../theme/app_theme.dart';

class CustomProgressIndicator {
  static closeProgress() {
    Navigator.of(Get.overlayContext!).pop();
  }

  static openProgress({String text = "Loading.."}) {
    Get.dialog(
      WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Center(
          child: SingleChildScrollView(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                padding: EdgeInsets.only(
                    left: 30.w, right: 30.w, top: 15.h, bottom: 15.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    text != ""
                        ? Text(
                            text,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: AppTheme.primaryColor,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Gordita",
                            ),
                          )
                        : Container(),
                    text != ""
                        ? SizedBox(
                            width: 15.w,
                          )
                        : Container(),
                    SizedBox(
                      width: 15.r,
                      height: 15.r,
                      child: const CircularProgressIndicator(
                        color: AppTheme.primaryColor,
                        strokeWidth: 2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      name: "Progress",
      barrierDismissible: false,
      useSafeArea: true,
    );
  }
}
