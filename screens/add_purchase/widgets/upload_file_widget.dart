import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:inventory_client/controllers/purchase/addedit_purchase_controller.dart';
import 'package:inventory_client/screens/add_purchase/widgets/pickedImagePurchase.dart';

import '../../../theme/app_theme.dart';

// ignore: must_be_immutable
class UploadFileWidget extends StatelessWidget {
  AddEditPurchaseScreenController addEditPurchaseScreenController;
  UploadFileWidget({
    required this.addEditPurchaseScreenController,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () async {
          await getImageBottomSheet(addEditPurchaseScreenController);
        },
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                blurRadius: 40.r,
                color: Colors.black.withOpacity(0.25),
                spreadRadius: -15,
                offset: Offset(0, 7.h),
              )
            ],
            borderRadius: BorderRadius.circular(15.r),
            color: Colors.white,
            border: Border.all(
              color: AppTheme.appGrayLite,
            ),
          ),
          width: double.infinity,
          height: 100.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/icons/upload.svg",
                width: 50.w,
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                "Upload File",
                style: TextStyle(
                  color: AppTheme.appGrayLite,
                  fontSize: 9.sp,
                ),
              ),
            ],
          ),
        ));
  }
}
