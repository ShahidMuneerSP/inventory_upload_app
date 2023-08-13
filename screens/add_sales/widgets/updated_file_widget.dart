import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventory_client/controllers/sales/add_edit_saleScreen_controller.dart';

import '../../../theme/app_theme.dart';

// ignore: must_be_immutable
class UpdatedFileWidget extends StatelessWidget {
  AddEditSaleScreenController addEditSaleScreenController;
  UpdatedFileWidget({
    required this.addEditSaleScreenController,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List filePaths = addEditSaleScreenController.pickedFilePathModel.value;
    List fileNames =
        filePaths.map((filePath) => filePath.split('/').last).toList();
    return Stack(
      alignment: AlignmentDirectional.topEnd,
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(color: AppTheme.primaryColor)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.r),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 15.h,
                  ),
                  const Icon(Icons.file_open, color: AppTheme.primaryColor),
                  Text(fileNames.join(",")),
                  SizedBox(
                    height: 15.h,
                  )
                ],
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            addEditSaleScreenController.pickedFilePathModel([]);
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.r),
              color: Colors.white,
            ),
            height: 25.h,
            width: 25.h,
            margin: EdgeInsets.all(5.r),
            padding: EdgeInsets.all(5.r),
            child: Center(
              child: Icon(
                Icons.close_rounded,
                size: 15.r,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
