import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomProgressIndicator {
  static closeProgress() {
    Navigator.of(Get.overlayContext!).pop();
  }

  static openProgress({String text = "Loading..", required Color color}) {
    Future.delayed(Duration.zero, () {
      showDialog(
        context: Get.overlayContext!,
        builder: (_) => WillPopScope(
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
                                color: color,
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.w500,
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
                        child: CircularProgressIndicator(
                          color: color,
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
        barrierDismissible: false,
        useSafeArea: true,
      );
    });
  }
}
