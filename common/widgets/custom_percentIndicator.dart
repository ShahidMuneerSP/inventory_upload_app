import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventory_client/theme/app_theme.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class CustomPercentIndicator extends StatelessWidget {
  const CustomPercentIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircularPercentIndicator(
          animationDuration: 1000,
          radius: 300.r,
          lineWidth: 40.w,
          percent: 0.4,
          progressColor: AppTheme.primaryColor,
          backgroundColor: AppTheme.shadedPrimaryColor,
          circularStrokeCap: CircularStrokeCap.round,
          center: Text(
            "100%",
            style: TextStyle(fontSize: 50.sp),
          ),
        ),
        // ignore: prefer_const_constructors
        LinearPercentIndicator(
          lineHeight: 40.h,
          percent: 0.5,
          progressColor: AppTheme.primaryColor,
          backgroundColor: AppTheme.shadedPrimaryColor,
        )
      ],
    );
  }
}
