import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///logo and title
class WidgetHead extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20.h,
        ),
        Text(
          'SignIn',
          style: TextStyle(
            fontFamily: 'Gordita',
            fontWeight: FontWeight.w500,
            fontSize: 20.sp,
          ),
        ),
      ],
    );
  }
}
