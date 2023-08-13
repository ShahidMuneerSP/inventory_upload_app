import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../theme/app_theme.dart';
import '../../add_purchase/add_purchase_screen.dart';

Widget widgetAppBar() {
  return Container(
    decoration: BoxDecoration(color: Colors.white, boxShadow: [
      BoxShadow(
        color: Colors.black12,
        spreadRadius: 1,
        offset: const Offset(0, 5),
        blurRadius: 20.r,
      )
    ]),
    padding: EdgeInsets.only(
      left: 10.w,
      top: 10.h,
      bottom: 10.h,
      right: 10.w,
    ),
    child: Row(
      children: [
        GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        SizedBox(
          width: 10.w,
        ),
        Text(
          "Purchase",
          style: TextStyle(
            fontSize: 14.sp,
            fontFamily: 'Gortita',
            fontWeight: FontWeight.w500,
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: () => Get.to(() => const AddPurchaseScreen()),
          child: Container(
            decoration: BoxDecoration(
              color: AppTheme.primaryColor,
              borderRadius: BorderRadius.circular(10.r),
            ),
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 20.w),
            child: Center(
              child: Text(
                "Add Purchase",
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        )
      ],
    ),
  );
}
