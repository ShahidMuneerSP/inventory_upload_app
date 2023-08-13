import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:inventory_client/theme/app_theme.dart';

Widget buttonItem({required String name, required String iconPath, var onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: AppTheme.primaryColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 20.r,
            spreadRadius: 2.r,
          ),
        ],
      ),
      height: 130.h,
      width: 130.h,
      padding: EdgeInsets.all(20.r),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              iconPath,
              color: Colors.white,
              height: 45.h,
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              name,
              style: TextStyle(
                fontSize: 11.sp,
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
      ),
    ),
  );
}
