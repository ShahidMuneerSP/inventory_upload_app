import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:inventory_client/screens/sales/sales_screen.dart';

import '../../../theme/app_theme.dart';
import '../../inventory/inventory_screen.dart';
import '../../login/login_screen.dart';
import '../../purchase/purchase_screen.dart';
import 'models/button_model.dart';

class HomeClientScreen extends StatelessWidget {
  const HomeClientScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(15.r),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10.h,
                ),
                //inventory text
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 15.w),
                      child: Text(
                        "Inventory",
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext ctx) {
                                return AlertDialog(
                                  title: const Text("Logout"),
                                  content: const Text('Are you sure?'),
                                  actions: [
                                    TextButton(
                                        onPressed: () async {
                                          Get.back();
                                        },
                                        child: const Text(
                                          'Cancel',
                                          style: TextStyle(
                                              color: AppTheme.primaryColor),
                                        )),
                                    TextButton(
                                        onPressed: () async {
                                          FlutterSecureStorage storage =
                                              const FlutterSecureStorage();

                                          await storage.deleteAll();
                                          Get.offAll(LoginScreen());
                                        },
                                        child: const Text(
                                          'Confirm',
                                          style: TextStyle(
                                              color: AppTheme.primaryColor),
                                        ))
                                  ],
                                );
                              });
                        },
                        icon: const Icon(
                          Icons.logout,
                          color: Colors.black54,
                        ))
                  ],
                ),
                SizedBox(
                  height: 30.h,
                ),
                //logo
                Center(
                  child: SvgPicture.asset(
                    "assets/svgs/svg1.svg",
                  ),
                ),
                SizedBox(
                  height: 50.h,
                ),
                Row(
                  children: [
                    const Spacer(),
                    //purchase button
                    buttonModel(
                        iconPath: "assets/icons/icon_purchase.svg",
                        name: "Purchase",
                        onTap: () {
                          Get.to(() => const PurchaseScreen());
                        }),
                    SizedBox(
                      width: 35.r,
                    ),
                    //sales button
                    buttonModel(
                      iconPath: "assets/icons/icon_sales.svg",
                      name: "Sales",
                      onTap: () {
                        Get.to(() => const SalesScreen());
                      },
                    ),
                    const Spacer(),
                  ],
                ),
                SizedBox(
                  height: 30.r,
                ),
                //inventory button
                Center(
                  child: buttonModel(
                    iconPath: "assets/icons/icon_inventory.svg",
                    name: "Inventory",
                    onTap: () {
                      Get.to(() => const InventoryScreen());
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
