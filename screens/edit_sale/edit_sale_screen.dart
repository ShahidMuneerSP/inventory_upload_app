import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:inventory_client/apis/sales/delete_saleFile_api.dart';
import 'package:inventory_client/models/sales_model.dart';
import 'package:inventory_client/screens/edit_sale/widgets/pickedImageEditSale.dart';
import 'package:inventory_client/screens/sales/sales_screen.dart';
import 'package:inventory_client/screens/sales/view_models/url_to_file.dart';
import '../../apis/sales/update_sale_api.dart';
import '../../common/widgets/custom_progressIndicator.dart';
import '../../common/widgets/custom_textFormField.dart';
import '../../constants/api_constants.dart';
import '../../controllers/sales/edit_sale_screen_controller.dart';
import '../../theme/app_theme.dart';
import '../widgets/open_failureDialog.dart';
import '../widgets/open_successDialog.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as path;

// ignore: must_be_immutable
class EditSaleScreen extends StatefulWidget {
  EditSaleScreen(
      {super.key,
      required this.index,
      required this.data,
      required this.dataModel});
  List<SaleFile> dataModel;
  final int index;
  final SalesModel data;

  @override
  State<EditSaleScreen> createState() => _EditSaleScreenState();
}

class _EditSaleScreenState extends State<EditSaleScreen> {
  var editTitleText = "";
  var editInvoiceText = "";
  var editDescriptionText = "";
  EditSaleScreenController editSaleScreenController =
      EditSaleScreenController();
  final storage = const FlutterSecureStorage();
  final _formKey = GlobalKey<FormState>();

  TextEditingController editTitleController = TextEditingController();

  TextEditingController editInvoiceNoController = TextEditingController();

  TextEditingController editDescriptionController = TextEditingController();
  @override
  void initState() {
    final value = salesScreenController.data[widget.index];
    editTitleController.text = value.title ?? "";
    editInvoiceNoController.text = value.invoiceNo ?? "";
    editDescriptionController.text = value.description ?? "";
    setState(() {
      editTitleText = (50 - editTitleController.text.length).toString();
      editInvoiceText = (50 - editInvoiceNoController.text.length).toString();
      editDescriptionText =
          (150 - editDescriptionController.text.length).toString();
    });
    getFileData();

    super.initState();
  }

  getFileData() {
    List<String> newValue = [];
    widget.data.saleFile?.forEach((element) {
      newValue.add("${ApiConstants.MEDIA_URL}/${element.file}");
    });
    log(newValue.toString());
    newValue.forEach((element) async {
      print(File(element));

      var file = File(await urlToFile(element));
      int? fileSize = file.lengthSync();
      double kb = fileSize / 1024;
      double mb = kb / 1024;
      final size = (mb >= 1)
          ? '${mb.toStringAsFixed(2)} MB'
          : '${kb.toStringAsFixed(2)} KB';
      print('File size: $size');
      final ext = path.extension(element);
      print(ext.split(".").last.toUpperCase());
      editSaleScreenController.pickedUrlPathModel.add(PickedFilePathModel(
          filename: await urlToFile(element),
          size: size,
          extensionValue: ext.split(".").last.toUpperCase()));
    });
    log(newValue.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            customAppBarWidget("Edit Sale"),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Obx(
                    () => Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 30.h,
                          ),
                          CustomTextFormField(
                            maxLength: 50,
                            maxLengthEnforcement: MaxLengthEnforcement.enforced,
                            onChanged: (value) {
                              setState(() {
                                editTitleText =
                                    (50 - editTitleController.text.length)
                                        .toString();
                              });
                            },
                            counterText:
                                "Remaining:${editTitleText.isEmpty ? 50 : editTitleText}",
                            controller: editTitleController,
                            hintText: "Title",
                            validator: (String? val) {
                              if (val == null || val.trim().isEmpty) {
                                return "Enter title";
                              }
                            },
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          CustomTextFormField(
                            maxLength: 50,
                            maxLengthEnforcement: MaxLengthEnforcement.enforced,
                            onChanged: (value) {
                              setState(() {
                                editInvoiceText =
                                    (50 - editInvoiceNoController.text.length)
                                        .toString();
                              });
                            },
                            counterText:
                                "Remaining:${editInvoiceText.isEmpty ? 50 : editInvoiceText}",
                            controller: editInvoiceNoController,
                            hintText: "Invoice Number",
                            validator: (String? val) {
                              if (val == null || val.trim().isEmpty) {
                                return "Enter invoice number";
                              }
                            },
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          CustomTextFormField(
                            maxLength: 150,
                            maxLengthEnforcement: MaxLengthEnforcement.enforced,
                            onChanged: (value) {
                              setState(() {
                                editDescriptionText =
                                    (150 - editDescriptionController.text.length)
                                        .toString();
                              });
                            },
                            counterText:
                                "Remaining:${editDescriptionText.isEmpty ? 150 : editDescriptionText}",
                            controller: editDescriptionController,
                            hintText: "Description",
                            validator: (String? val) {
                              if (val == null || val.trim().isEmpty) {
                                return "Enter description";
                              }
                            },
                            maxLines: 4,
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Column(
                            children: [
                              //upload file
                              UploadFileWidget(
                                editSaleScreenController:
                                    editSaleScreenController,
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              //url file showing cards
                              editSaleScreenController
                                      .pickedUrlPathModel.value.isEmpty
                                  ? Container()
                                  : Container(
                                      // height: 250.h,
                                      width: double.infinity,
                                      child: ListView.separated(
                                        physics: const BouncingScrollPhysics(),
                                        itemCount: editSaleScreenController
                                            .pickedUrlPathModel.length,
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Stack(
                                            alignment:
                                                AlignmentDirectional.topEnd,
                                            children: [
                                              Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.r),
                                                    border: Border.all(
                                                        color: AppTheme
                                                            .primaryColor)),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.r),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          height: 15.h,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: const [
                                                            Icon(
                                                                Icons.file_open,
                                                                color: AppTheme
                                                                    .primaryColor),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 5.h,
                                                        ),
                                                        Text(
                                                          editSaleScreenController
                                                                  .pickedUrlPathModel[
                                                                      index]
                                                                  .filename
                                                                  ?.split("/")
                                                                  .last
                                                                  .split(".")
                                                                  .first ??
                                                              "",
                                                          style: TextStyle(
                                                              fontSize: 15.sp),
                                                        ),
                                                        SizedBox(
                                                          height: 2.h,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              editSaleScreenController
                                                                      .pickedUrlPathModel[
                                                                          index]
                                                                      .size ??
                                                                  "",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black54,
                                                                  fontSize:
                                                                      12.sp),
                                                            ),
                                                            Text(
                                                              editSaleScreenController
                                                                      .pickedUrlPathModel[
                                                                          index]
                                                                      .extensionValue ??
                                                                  "",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black87,
                                                                  fontSize:
                                                                      14.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                          ],
                                                        ),
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
                                                  showDialog(
                                                      context: context,
                                                      builder:
                                                          (BuildContext ctx) {
                                                        return AlertDialog(
                                                          content: const Text(
                                                              'Do you want to remove?'),
                                                          actions: [
                                                            TextButton(
                                                                onPressed:
                                                                    () async {
                                                                  bool data = await deleteSaleFileApi(widget
                                                                          .dataModel[
                                                                              index]
                                                                          .id ??
                                                                      "");
                                                                  if (data ==
                                                                      true) {
                                                                    editSaleScreenController
                                                                        .pickedUrlPathModel
                                                                        .removeAt(
                                                                            index);
                                                                  }
                                                                  Get.back();
                                                                },
                                                                child:
                                                                    const Text(
                                                                  'Yes',
                                                                  style: TextStyle(
                                                                      color: AppTheme
                                                                          .primaryColor),
                                                                )),
                                                            TextButton(
                                                                onPressed: () {
                                                                  // Close the dialog
                                                                  Get.back();
                                                                },
                                                                child:
                                                                    const Text(
                                                                  'No',
                                                                  style: TextStyle(
                                                                      color: AppTheme
                                                                          .primaryColor),
                                                                ))
                                                          ],
                                                        );
                                                      });
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50.r),
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
                                        },
                                        separatorBuilder:
                                            (BuildContext context, int index) {
                                          return SizedBox(
                                            height: 10.h,
                                          );
                                        },
                                      ),
                                    ),
                              SizedBox(
                                height: 10.h,
                              ),
                              //upload file showing Cards
                              editSaleScreenController
                                      .pickedFilePathModel.value.isEmpty
                                  ? Container()
                                  : Container(
                                      // height: 250.h,
                                      width: double.infinity,
                                      child: ListView.separated(
                                        physics: const BouncingScrollPhysics(),
                                        itemCount: editSaleScreenController
                                            .pickedFilePathModel.length,
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Stack(
                                            alignment:
                                                AlignmentDirectional.topEnd,
                                            children: [
                                              Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.r),
                                                    border: Border.all(
                                                        color: AppTheme
                                                            .primaryColor)),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.r),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          height: 15.h,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: const [
                                                            Icon(
                                                                Icons.file_open,
                                                                color: AppTheme
                                                                    .primaryColor),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 5.h,
                                                        ),
                                                        Text(
                                                          editSaleScreenController
                                                                  .pickedFilePathModel[
                                                                      index]
                                                                  .filename
                                                                  ?.split("/")
                                                                  .last
                                                                  .split(".")
                                                                  .first ??
                                                              "",
                                                          style: TextStyle(
                                                              fontSize: 15.sp),
                                                        ),
                                                        SizedBox(
                                                          height: 2.h,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              editSaleScreenController
                                                                      .pickedFilePathModel[
                                                                          index]
                                                                      .size ??
                                                                  "",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black54,
                                                                  fontSize:
                                                                      12.sp),
                                                            ),
                                                            Text(
                                                              editSaleScreenController
                                                                      .pickedFilePathModel[
                                                                          index]
                                                                      .extensionValue ??
                                                                  "",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black87,
                                                                  fontSize:
                                                                      14.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                          ],
                                                        ),
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
                                                  editSaleScreenController
                                                      .pickedFilePathModel
                                                      .removeAt(index);
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50.r),
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
                                        },
                                        separatorBuilder:
                                            (BuildContext context, int index) {
                                          return SizedBox(
                                            height: 10.h,
                                          );
                                        },
                                      ),
                                    ),
                            ],
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          GestureDetector(
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                CustomProgressIndicator.openProgress();

                                final userId =
                                    await storage.read(key: "userId");

                                bool updateData = await updateSaleApi(
                                    SaleId: salesScreenController
                                            .data[widget.index].id ??
                                        "",
                                    UserId: userId,
                                    Title: editTitleController.text,
                                    InvoiceNo: editInvoiceNoController.text,
                                    Description: editDescriptionController.text,
                                    images: editSaleScreenController
                                        .pickedFilePathModel.value);

                                log(updateData.toString());

                                if (updateData == true) {
                                  CustomProgressIndicator.closeProgress();
                                  salesScreenController.getData();

                                  // ignore: use_build_context_synchronously
                                  openSuccessDialog(
                                      context, "Updated Successfully");
                                } else {
                                  CustomProgressIndicator.closeProgress();
                                  // ignore: use_build_context_synchronously
                                  openFailureDialog(context, "Update Failed!!");
                                }
                              }
                            },
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                vertical: 19.h,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                color: AppTheme.primaryColor,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 30.r,
                                    color: AppTheme.primaryColor,
                                    spreadRadius: -10,
                                    offset: Offset(0, 10.h),
                                  )
                                ],
                              ),
                              child: Text(
                                "Edit",
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class UploadFileWidget extends StatelessWidget {
  EditSaleScreenController editSaleScreenController;
  UploadFileWidget({Key? key, required this.editSaleScreenController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () async {
          await getImageBottomSheet(editSaleScreenController);
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

Widget customAppBarWidget(String title) {
  return Container(
    decoration: BoxDecoration(color: Colors.white, boxShadow: [
      BoxShadow(
        color: Colors.black12,
        spreadRadius: 1,
        offset: const Offset(0, 5),
        blurRadius: 20.r,
      )
    ]),
    padding: EdgeInsets.only(
      left: 10.w,
      top: 15.h,
      bottom: 15.h,
      right: 10.w,
    ),
    child: Row(
      children: [
        GestureDetector(
          onTap: () {
            salesScreenController.getData();
            Get.back();
          },
          child: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        SizedBox(
          width: 10.w,
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 14.sp,
            fontFamily: 'Gortita',
            fontWeight: FontWeight.w500,
          ),
        ),
        const Spacer(),
      ],
    ),
  );
}
