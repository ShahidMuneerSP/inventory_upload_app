import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../theme/app_theme.dart';

class PendingStatusWidget extends StatelessWidget {
  const PendingStatusWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: AppTheme.liteRedColor,
        borderRadius: BorderRadius.circular(5.r),
      ),
      child: Text(
        "Pending",
        style: TextStyle(
            fontSize: 11.sp,
            fontFamily: "Gordita",
            fontWeight: FontWeight.w500,
            color: AppTheme.deleteRedColor),
      ),
    );
  }
}
