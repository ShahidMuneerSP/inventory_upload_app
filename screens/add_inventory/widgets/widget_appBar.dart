import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../theme/app_theme.dart';

Widget widgetAppBar(BuildContext context) {
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
      top: 15.h,
      bottom: 15.h,
      right: 10.w,
    ),
    child: Row(
      children: [
        GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: const Text('Do you want to exit?'),
                  actions: <Widget>[
                    TextButton(
                        onPressed: () async {
                          Get.back();
                          Get.back();
                        },
                        child: const Text(
                          'Yes',
                          style: TextStyle(color: AppTheme.primaryColor),
                        )),
                    TextButton(
                        onPressed: () {
                          // Close the dialog
                          Get.back();
                        },
                        child: const Text(
                          'No',
                          style: TextStyle(color: AppTheme.primaryColor),
                        ))
                  ],
                );
              },
            );
          },
          child: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        SizedBox(
          width: 10.w,
        ),
        Text(
          "Add Inventory",
          style: TextStyle(
            fontSize: 14.sp,
            fontFamily: 'Gortita',
            fontWeight: FontWeight.w500,
          ),
        ),
        const Spacer(),
      ],
    ),
  );
}
