
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventory_client/theme/app_theme.dart';

Future openDialog(BuildContext context) => showDialog(
    context: context,
    builder: (context) => AlertDialog(
          content: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(16),
            child: TweenAnimationBuilder(
              builder: (context, value, _) => SizedBox(
                width: 200.w,
                height: 200.h,
                child: CircularProgressIndicator(
                  value: 0.5,
                  color: AppTheme.primaryColor,
                  backgroundColor: AppTheme.shadedPrimaryColor,
                  strokeWidth: 16,
                ),
              ),
              tween: Tween(begin: 0.0, end: 1.0),
              duration: const Duration(seconds: 1),
            ),
          ),
        ));
