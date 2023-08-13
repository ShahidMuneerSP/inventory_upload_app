import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:inventory_client/models/purchase_model.dart';
import 'package:inventory_client/screens/list_purchase/view_models/open_file.dart';
import 'package:inventory_client/screens/list_purchase/widgets/pending_status_widget.dart';
import 'package:inventory_client/screens/list_purchase/widgets/processing_status_widget.dart';
import 'package:inventory_client/theme/app_theme.dart';

import '../../../../constants/api_constants.dart';
import '../../../common/view_models/convert_utc_to_local.dart';
import 'completed_status_widget.dart';

enum Status {
  pending,
  processing,
  completed,
}

Widget listItemPurchaseWidget(PurchaseModel data, BuildContext context) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
    margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15.r),
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 20.r,
          spreadRadius: -2.r,
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.description,
              size: 20.r,
              color: AppTheme.primaryColor,
            ),
            SizedBox(
              width: 5.w,
            ),
            Text(
              data.title ?? "",
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            // ignore: unrelated_type_equality_checks
            data.status == Status.pending
                ? const PendingStatusWidget()
                // ignore: unrelated_type_equality_checks
                : data.status == Status.processing
                    ? const ProcessingStatusWidget()
                    // ignore: unrelated_type_equality_checks
                    : data.status == Status.completed
                        ? const CompletedStatusWidget()
                        : const PendingStatusWidget(),
          ],
        ),
        SizedBox(
          height: 7.h,
        ),
        Row(
          children: [
            Icon(
              Icons.format_list_numbered,
              size: 18.r,
              color: AppTheme.primaryColor,
            ),
            SizedBox(
              width: 5.w,
            ),
            Text(
              data.invoiceNo ?? "",
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 7.h,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: TextFormField(
            readOnly: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: const BorderSide(
                  color: AppTheme.liteGreenColor,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: const BorderSide(
                  color: AppTheme.liteGreenColor,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7.r),
                borderSide: const BorderSide(
                  color: AppTheme.liteGreenColor,
                  width: 1.5,
                ),
              ),
              hintText: data.description ?? "",
              hintStyle: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.black54),
              labelText: "Description",
              labelStyle: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 11.sp,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        SingleChildScrollView(
          child: Container(
            // height: 50.h,
            width: 120.w,
            child: ListView.separated(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: data.purchaseFile!.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () => openFile(
                      "${ApiConstants.MEDIA_URL}/${data.purchaseFile![index].file}"),
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 5.h, horizontal: 15.w),
                    decoration: BoxDecoration(
                        color: AppTheme.liteYelow,
                        borderRadius: BorderRadius.circular(5.r)),
                    child: Text(
                      data.purchaseFile?[index].file?.split("/").last ?? "",
                      style: TextStyle(
                        fontSize: 9.sp,
                        fontWeight: FontWeight.w400,
                        color: AppTheme.darkYellow,
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: 10.h,
                );
              },
            ),
          ),
        ),
        Row(
          children: [
            const Spacer(),
            Text(
              DateFormat("dd-MM-yyyy hh:mm aa")
                  .format(utcToLocal(data.createdAt.toString())),
              style: TextStyle(
                fontSize: 8.sp,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        )
      ],
    ),
  );
}
