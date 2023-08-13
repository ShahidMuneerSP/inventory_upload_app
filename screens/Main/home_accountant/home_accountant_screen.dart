import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:inventory_client/screens/Main/home_accountant/models/button_model.dart';
import 'package:inventory_client/screens/login/login_screen.dart';

import '../../../theme/app_theme.dart';
import '../../list_inventory/listinventory_screen.dart';
import '../../list_purchase/list_purchase_screen.dart';
import '../../list_sales/listsales_screen.dart';

class HomeAccountantScreen extends StatelessWidget {
  const HomeAccountantScreen({super.key});

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
                    "assets/icons/inventory-admin-home 1.svg",
                  ),
                ),
                SizedBox(
                  height: 50.h,
                ),

                Row(
                  children: [
                    const Spacer(),
                    //list sales button
                    buttonItem(
                        iconPath: "assets/icons/listSales.svg",
                        name: "List Sales",
                        onTap: () {
                          Get.to(() => const ListSalesScreen());
                        }),
                    SizedBox(
                      width: 35.r,
                    ),
                    //List Purchase button
                    buttonItem(
                      iconPath: "assets/icons/listPurchase.svg",
                      name: "List Purchase",
                      onTap: () {
                        Get.to(() => const ListPurchaseScreen());
                      },
                    ),
                    const Spacer(),
                  ],
                ),
                SizedBox(
                  height: 30.r,
                ),

                //List Inventory button
                Center(
                  child: buttonItem(
                    iconPath: "assets/icons/ListInventory.svg",
                    name: "List Inventory",
                    onTap: () {
                      Get.to(() => const ListInventoryScreen());
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
