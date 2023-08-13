import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../theme/app_theme.dart';

Future<dynamic> openDeleteDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) => AlertDialog(
            content: SingleChildScrollView(
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      "Do you want to delete ?",
                      style: TextStyle(
                          color: AppTheme.deleteRedColor, fontSize: 16.sp),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      children: [
                        const Spacer(),
                        ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    AppTheme.deleteRedColor)),
                            onPressed: () {
                              Get.back();
                            },
                            child: const Text(
                              " No",
                              style: TextStyle(color: Colors.white),
                            )),
                        const Spacer(),
                        ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    AppTheme.deleteRedColor)),
                            onPressed: () {
                              Get.back();
                            },
                            child: const Text(
                              "Yes",
                              style: TextStyle(color: Colors.white),
                            )),
                        const Spacer()
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ));
}
