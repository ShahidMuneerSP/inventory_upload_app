import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../theme/app_theme.dart';

///custom textformfield
// ignore: must_be_immutable
class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    this.labelText,
    this.validatorText,
    this.prefixIcon,
    this.validator,
    this.obsecureText = false,
    this.readOnly = false,
    this.inputFormatters,
    this.maxLines,
    this.onChanged,
    this.maxLength,
    this.counterText,
    this.maxLengthEnforcement
  });

  Widget? prefixIcon;
  TextEditingController controller;
  String hintText;
  String? counterText;
  String? labelText;
  String? validatorText;
  var maxLengthEnforcement;
  // ignore: prefer_typing_uninitialized_variables
  var validator;
  bool obsecureText;
  bool readOnly;
  List<TextInputFormatter>? inputFormatters;
  int? maxLines;
  int? maxLength;
  var onChanged;

  // ignore: prefer_typing_uninitialized_variables
  // OnTap? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // border: Border.all(color: AppColors.appGrayLite),
        // color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            blurRadius: 40.r,
            color: Colors.black.withOpacity(0.25),
            spreadRadius: -15,
            offset: Offset(0, 7.h),
          )
        ],
      ),
      child: TextFormField(
        maxLengthEnforcement: maxLengthEnforcement,
        maxLength: maxLength,
        onChanged: onChanged,
        controller: controller,

        validator: validator ??
            (value) {
              if (value == null || value.trim().isEmpty) {
                return validatorText;
              }
              return null;
            },
        inputFormatters: inputFormatters,
        // cursorHeight: 20.h,
        decoration: InputDecoration(
          counterText: counterText,
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
          ),
          labelText: labelText,
          labelStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 12.sp,
            color: Colors.black54,
          ),

          // contentPadding: EdgeInsets.all(15.r),
          fillColor: Colors.white,
          focusColor: Colors.white,
          hoverColor: Colors.white,
          filled: true,
          prefixIcon: prefixIcon,
          prefixIconConstraints: BoxConstraints(
            maxWidth: 55.w,
          ),

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: const BorderSide(
              color: AppTheme.appGrayLite,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: const BorderSide(
              color: AppTheme.appGrayLite,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: const BorderSide(
              color: AppTheme.appGrayLite,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7.r),
            borderSide: const BorderSide(
              color: AppTheme.primaryColor,
              width: 1.5,
            ),
          ),
        ),
        style: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
        ),
        obscureText: obsecureText,
        obscuringCharacter: "*",
        readOnly: readOnly,
        maxLines: obsecureText ? 1 : maxLines,
      ),
    );
  }
}
