import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:inventory_client/models/purchase_model.dart';
import 'package:inventory_client/screens/edit_purchase/edit_purchase.dart';
import 'package:inventory_client/screens/purchase/purchase_screen.dart';
import '../../../apis/purchase/delete_purchase_api.dart';
import '../../../common/view_models/convert_utc_to_local.dart';
import '../../../constants/api_constants.dart';
import '../../../theme/app_theme.dart';
import '../view_models/open_file.dart';

Widget widgetListItem(PurchaseModel data, int index, BuildContext context) {
  TextEditingController controller = TextEditingController();
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
            Expanded(
              child: Text(
                data.title ?? "",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Spacer(),
            InkWell(
                onTap: () {
                  Get.to(EditPurchaseScreen(
                    index: index,
                    data: data,
                    dataModel: data.purchaseFile ?? [],
                  ));
                },
                child: SvgPicture.asset("assets/icons/icon_edit.svg")),
          ],
        ),
        SizedBox(
          height: 7.h,
        ),
        Row(
          children: [
            Icon(
              Icons.format_list_numbered,
              size: 20.r,
              color: AppTheme.primaryColor,
            ),
            SizedBox(
              width: 5.w,
            ),
            Expanded(
              child: Text(
                data.invoiceNo ?? "--",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const Spacer(),
            GestureDetector(
                onTap: () => showDialog(
                    context: context,
                    builder: (BuildContext ctx) {
                      return AlertDialog(
                        content: const Text('Do you want to delete?'),
                        actions: [
                          TextButton(
                              onPressed: () async {
                                deletePurchaseApi(purchaseScreenController
                                    .data[index].id
                                    .toString());

                                Get.back();
                              },
                              child: const Text(
                                'Yes',
                                style: TextStyle(color: AppTheme.primaryColor),
                              )),
                          TextButton(
                              onPressed: () {
                                // Close the dialog
                                Get.back();
                              },
                              child: const Text(
                                'No',
                                style: TextStyle(color: AppTheme.primaryColor),
                              ))
                        ],
                      );
                    }),
                child: Icon(
                  Icons.delete,
                  size: 20.r,
                  color: AppTheme.deleteRedColor,
                )),
          ],
        ),
        SizedBox(
          height: 10.h,
        ),
        //description
        Padding(
          padding: EdgeInsets.only(right: 25.w),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: TextFormField(
              maxLines: 3,
              readOnly: true,
              controller: controller,
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
        ),
        SizedBox(
          height: 10.h,
        ),
        //view file
        SingleChildScrollView(
          child: Container(
            height: 30.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
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
                    child: Center(
                      child: Text(
                        data.purchaseFile![index].file?.split("/").last ?? "",
                        style: TextStyle(
                          fontSize: 9.sp,
                          fontWeight: FontWeight.w400,
                          color: AppTheme.darkYellow,
                        ),
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  width: 10.w,
                );
              },
            ),
          ),
        ),
        SizedBox(
          height: 7.h,
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
