import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:inventory_client/apis/inventory/delete_inventoryfile_api.dart';
import 'package:inventory_client/models/inventory_model.dart';
import 'package:inventory_client/screens/edit_inventory/widgets/pickedImageEditInventory.dart';
import 'package:inventory_client/screens/inventory/inventory_screen.dart';
import '../../apis/inventory/update_inventory_api.dart';
import '../../common/widgets/custom_progressIndicator.dart';
import '../../common/widgets/custom_textFormField.dart';
import '../../constants/api_constants.dart';
import '../../controllers/inventory/edit_inventory_controller.dart';
import '../../theme/app_theme.dart';
import '../sales/view_models/url_to_file.dart';
import '../widgets/open_failureDialog.dart';
import '../widgets/open_successDialog.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as path;

// ignore: must_be_immutable
class EditInventoryScreen extends StatefulWidget {
  EditInventoryScreen(
      {super.key,
      required this.index,
      required this.data,
      required this.dataModel});
  final int index;
  final InventoryModel data;
  List<InventoryFile> dataModel;
  @override
  State<EditInventoryScreen> createState() => _EditInventoryScreenState();
}

class _EditInventoryScreenState extends State<EditInventoryScreen> {
  var editTitleText = "";
  var editInvoiceText = "";
  var editDescriptionText = "";
  EditInventoryScreenController editInventoryScreenController =
      EditInventoryScreenController();
  final storage = const FlutterSecureStorage();
  final _formKey = GlobalKey<FormState>();

  TextEditingController editTitleController = TextEditingController();

  TextEditingController editInvoiceNoController = TextEditingController();

  TextEditingController editDescriptionController = TextEditingController();

  @override
  void initState() {
    final value = inventoryScreenController.data[widget.index];
    editTitleController.text = value.title ?? "";
    editInvoiceNoController.text = value.invoiceNo ?? "";
    editDescriptionController.text = value.description ?? "";
    //  String? textLength;
    setState(() {
      editTitleText = (50 - editTitleController.text.length).toString();
      editInvoiceText = (50 - editInvoiceNoController.text.length).toString();
      editDescriptionText =
          (150 - editDescriptionController.text.length).toString();
    });
    print(editTitleText);
    getFileData();
    super.initState();
  }

  getFileData() {
    List<String> newValue = [];
    widget.data.inventoryFile?.forEach((element) {
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
      editInventoryScreenController.pickedUrlPathModel.add(PickedFilePathModel(
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
            customAppBarWidget("Edit Inventory"),
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
                            maxLengthEnforcement: MaxLengthEnforcement.enforced,
                            maxLength: 50,
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
                            maxLengthEnforcement: MaxLengthEnforcement.enforced,
                            maxLength: 50,
                            onChanged: (value) {
                              setState(() {
                                editInvoiceText =
                                    (50 - editInvoiceNoController.text.length)
                                        .toString();
                              });
                            },
                            controller: editInvoiceNoController,
                            counterText:
                                "Remaining:${editInvoiceText.isEmpty ? 50 : editInvoiceText}",
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
                                editDescriptionText = (150 -
                                        editDescriptionController.text.length)
                                    .toString();
                              });
                            },
                            controller: editDescriptionController,
                            counterText:
                                "Remaining:${editDescriptionText.isEmpty ? 150 : editDescriptionText}",
                            hintText: "Description",
                            validator: (String? val) {
                              if (val == null || val.trim().isEmpty) {
                                return "Enter description";
                              }
                            },
                            maxLines: 3,
                          ),
                          SizedBox(
                            height: 20.h,
                          ),

                          //updated pdf
                          Column(
                            children: [
                              UploadFileWidget(
                                editInventoryScreenController:
                                    editInventoryScreenController,
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              editInventoryScreenController
                                      .pickedUrlPathModel.value.isEmpty
                                  ? Container()
                                  : Container(
                                      // height: 250.h,
                                      width: double.infinity,
                                      child: ListView.separated(
                                        physics: const BouncingScrollPhysics(),
                                        itemCount: editInventoryScreenController
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
                                                          editInventoryScreenController
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
                                                              editInventoryScreenController
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
                                                              editInventoryScreenController
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
                                                                  bool data = await deleteInventoryFileApi(widget
                                                                          .dataModel[
                                                                              index]
                                                                          .id ??
                                                                      "");
                                                                  if (data ==
                                                                      true) {
                                                                    log("Success");

                                                                    editInventoryScreenController
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
                                                  //
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
                              editInventoryScreenController
                                      // ignore: invalid_use_of_protected_member
                                      .pickedFilePathModel
                                      .value
                                      .isEmpty
                                  ? Container()
                                  : Container(
                                      // height: 250.h,
                                      width: double.infinity,
                                      child: ListView.separated(
                                        physics: const BouncingScrollPhysics(),
                                        itemCount: editInventoryScreenController
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
                                                          editInventoryScreenController
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
                                                              editInventoryScreenController
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
                                                              editInventoryScreenController
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
                                                  editInventoryScreenController
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

                                bool updateData = await updateInventoryApi(
                                    InventoryId: inventoryScreenController
                                            .data[widget.index].id ??
                                        "",
                                    UserId: userId,
                                    Title: editTitleController.text,
                                    InvoiceNo: editInvoiceNoController.text,
                                    Description: editDescriptionController.text,
                                    images: editInventoryScreenController
                                        .pickedFilePathModel.value);

                                log(updateData.toString());

                                if (updateData == true) {
                                  CustomProgressIndicator.closeProgress();
                                  inventoryScreenController.getData();

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
  EditInventoryScreenController editInventoryScreenController;
  UploadFileWidget({Key? key, required this.editInventoryScreenController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () async {
          await getImageBottomSheet(editInventoryScreenController);
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
            inventoryScreenController.getData();
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
