import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inventory_client/theme/app_theme.dart';

Future openFailureDialog(BuildContext context, String title) => showDialog(
    context: context,
    builder: (context) => AlertDialog(
          content: SingleChildScrollView(
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        color: AppTheme.deleteRedColor, fontSize: 16.sp),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              AppTheme.deleteRedColor)),
                      onPressed: () {
                        Get.back();
                      },
                      child: const Text(
                        "Retry",
                      )),
                ],
              ),
            ),
          ),
        ));
