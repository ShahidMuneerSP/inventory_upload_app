import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:inventory_client/apis/inventory/add_inventory_api.dart';
import 'package:inventory_client/screens/add_inventory/widgets/upload_file_widget.dart';
import '../../common/widgets/custom_progressIndicator.dart';
import '../../common/widgets/custom_textFormField.dart';
import '../../controllers/inventory/add_edit_inventoryScreen_controller.dart';
import '../../models/sales_model.dart';
import '../../theme/app_theme.dart';
import '../inventory/inventory_screen.dart';
import '../widgets/open_failureDialog.dart';
import '../widgets/open_successDialog.dart';
import 'widgets/widget_appBar.dart';

class AddInventoryScreen extends StatefulWidget {
  const AddInventoryScreen({super.key});

  @override
  State<AddInventoryScreen> createState() => _AddInventoryScreenState();
}

class _AddInventoryScreenState extends State<AddInventoryScreen> {
  var titleText = "";
  var invoiceText = "";
  var descriptionText = "";
  //page controller
  AddEditInventoryScreenController addEditInventoryScreenController =
      AddEditInventoryScreenController();

  final storage = const FlutterSecureStorage();
  final _formKey = GlobalKey<FormState>();
  late SalesModel salesModel;

  //controllers
  TextEditingController titleController = TextEditingController();
  TextEditingController invoiceNoController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  @override
  void initState() {
    addEditInventoryScreenController.pickedFilePathModel([]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            //appbar
            widgetAppBar(context),
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
                          //title textfield
                          CustomTextFormField(
                            onChanged: (value) {
                              setState(() {
                                titleText = (50 - titleController.text.length)
                                    .toString();
                              });
                            },
                            maxLengthEnforcement: MaxLengthEnforcement.enforced,
                            maxLines: 1,
                            maxLength: 50,
                            counterText:
                                "Remaining:${titleText.isEmpty ? 50 : titleText}",
                            controller: titleController,
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
                          //invoice number textfield
                          CustomTextFormField(
                            onChanged: (value) {
                              setState(() {
                                invoiceText =
                                    (50 - invoiceNoController.text.length)
                                        .toString();
                              });
                            },
                            maxLengthEnforcement: MaxLengthEnforcement.enforced,
                            maxLines: 1,
                            maxLength: 50,
                            counterText:
                                "Remaining:${invoiceText.isEmpty ? 50 : invoiceText} ",
                            controller: invoiceNoController,
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
                          //description textfield
                          CustomTextFormField(
                            maxLengthEnforcement: MaxLengthEnforcement.enforced,
                            onChanged: (value) {
                              setState(() {
                                descriptionText =
                                    (150 - descriptionController.text.length)
                                        .toString();
                              });
                            },
                            maxLength: 150,
                            counterText:
                                "Remaining:${descriptionText.isEmpty ? 150 : descriptionText}",
                            controller: descriptionController,
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
                          Column(
                            children: [
                              //upload file
                              UploadFileWidget(
                                addEditInventoryScreenController:
                                    addEditInventoryScreenController,
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              addEditInventoryScreenController
                                      // ignore: invalid_use_of_protected_member
                                      .pickedFilePathModel
                                      .value
                                      .isEmpty
                                  ? Container()
                                  : Container(
                                      // height: 150.h,
                                      width: double.infinity,
                                      child: ListView.separated(
                                        physics: const BouncingScrollPhysics(),
                                        itemCount:
                                            addEditInventoryScreenController
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
                                                        const Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Icon(
                                                                Icons.file_open,
                                                                color: AppTheme
                                                                    .primaryColor),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 5.h,
                                                        ),
                                                        //filename
                                                        Text(
                                                          addEditInventoryScreenController
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
                                                            //file size
                                                            Text(
                                                              addEditInventoryScreenController
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
                                                            //file extension
                                                            Text(
                                                              addEditInventoryScreenController
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
                                                  addEditInventoryScreenController
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
                            height: 40.h,
                          ),
                          //Add button
                          GestureDetector(
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                // log(addEditInventoryScreenController
                                //     .pickedFilePath.value);
                                CustomProgressIndicator.openProgress();
                                // final file = File(
                                //     addEditInventoryScreenController
                                //         .pickedFilePath.value);
                                // print(file.toString());
                                final userId =
                                    await storage.read(key: "userId");
                                //addInventoryApi calling

                                bool data = await addInventoryApi(
                                    UserId: userId,
                                    Title: titleController.text,
                                    InvoiceNo: invoiceNoController.text,
                                    Description: descriptionController.text,
                                    images: addEditInventoryScreenController
                                        .pickedFilePathModel.value);
                                log(data.toString());

                                if (data == true) {
                                  CustomProgressIndicator.closeProgress();
                                  inventoryScreenController.getData();
                                  //success dialog
                                  // ignore: use_build_context_synchronously
                                  openSuccessDialog(
                                      context, "Uploaded Successfully");
                                } else {
                                  CustomProgressIndicator.closeProgress();
                                  //failure dialog
                                  // ignore: use_build_context_synchronously
                                  openFailureDialog(context, "Upload Failed!!");
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
                                "Add",
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
