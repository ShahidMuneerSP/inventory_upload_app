import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inventory_client/constants/user_credentials.dart';
import 'package:inventory_client/screens/splash/view_models/get_all_data.dart';

import '../../theme/app_theme.dart';
import '../Main/home_accountant/home_accountant_screen.dart';
import '../Main/home_client/home_client_screen.dart';
import '../login/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLogined = false;

  @override
  void initState() {
    super.initState();

    getData();

    Future.delayed(
      const Duration(seconds: 3),
      () {
        if (isLogined) {
          if (userType == 3) {
            Get.offAll(() => const HomeClientScreen());
          } else if (userType == 4) {
            Get.offAll(() => const HomeAccountantScreen());
          }
        } else {
          Get.off(() => LoginScreen());
        }
      },
    );
  }

  getData() async {
    isLogined = await getAlldata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        //logo
        child: Text(
          "LOGO",
          style: TextStyle(
            fontSize: 20.sp,
            color: AppTheme.primaryColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
