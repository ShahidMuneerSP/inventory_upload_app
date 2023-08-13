import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../theme/app_theme.dart';

Future openSuccessDialog(BuildContext context, String title) => showDialog(
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
                        color: AppTheme.primaryColor, fontSize: 16.sp),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(AppTheme.primaryColor)),
                      onPressed: () {
                        Get.back();
                        Get.back();
                      },
                      child: const Text(
                        "Ok",
                      )),
                ],
              ),
            ),
          ),
        ));
