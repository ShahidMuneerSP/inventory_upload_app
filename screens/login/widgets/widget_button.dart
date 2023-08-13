import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inventory_client/constants/user_credentials.dart';

import '../../../apis/auth/login_api.dart';
import '../../../controllers/loginsScreen_controller.dart';
import '../../../theme/app_theme.dart';
import '../../Main/home_accountant/home_accountant_screen.dart';
import '../../Main/home_client/home_client_screen.dart';
import '../view_models/save_data.dart';

Widget widgetButton(
  GlobalKey<FormState> formKey,
  TextEditingController username,
  TextEditingController password,
  LoginScreenController loginScreenController,
) {
  return GestureDetector(
    onTap: () async {
      if (formKey.currentState!.validate()) {
        loginScreenController.isLoading(true);
        Map? data =
            await apiLogin(username: username.text, password: password.text);

        if (data != null) {
          loginScreenController.isAuthFailed(false);
          bool status = await saveData(data);
          loginScreenController.isLoading(false);
          if (status) {
            if (userType == 3) {
              Get.offAll(() => const HomeClientScreen());
            } else if (userType == 4) {
              Get.offAll(() => const HomeAccountantScreen());
            }
          }
        } else {
          loginScreenController.isAuthFailed(true);
          loginScreenController.isLoading(false);
        }
      }
    },
    child: Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: 19.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: AppTheme.primaryColor,
        boxShadow: [
          BoxShadow(
            blurRadius: 30.r,
            color: AppTheme.primaryColor,
            spreadRadius: -10,
            offset: Offset(0, 10.h),
          )
        ],
      ),
      child: Center(
        child: Obx(
          () => loginScreenController.isLoading.value
              ? SizedBox(
                  height: 20.r,
                  width: 20.r,
                  child: const CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
              : Text(
                  'SignIn',
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
        ),
      ),
    ),
  );
}
