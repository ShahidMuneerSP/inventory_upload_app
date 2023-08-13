import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../common/widgets/custom_textFormField.dart';

Widget widgetUsername(TextEditingController controller) {
  return CustomTextFormField(
    controller: controller,
    hintText: "Username",
    prefixIcon: Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
      child: SvgPicture.asset(
        'assets/icons/username.svg',
        width: 25.w,
      ),
    ),
    validator: (String? val) {
      if (val == null || val.trim().isEmpty) {
        return "Enter username";
      }
    },
  );
}
