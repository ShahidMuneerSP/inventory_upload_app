import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as path;
import '../../../controllers/purchase/edit_purchase_controller.dart';

pickMultileFiles(
    BuildContext context, EditPurchaseScreenController controller) async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [
        'pdf',
        'doc',
        'docx',
        'xls',
        'xlsx',
        'jpg',
        'jpeg',
        'png'
      ],
      allowMultiple: true);
  if (result != null) {
    List<File> files = [];
    files = result.paths.map((path) => File(path!)).toList();
    for (var pickedPath in files) {
      int? fileSize = pickedPath.lengthSync();
      double kb = fileSize / 1024;
      double mb = kb / 1024;
      final size = (mb >= 1)
          ? '${mb.toStringAsFixed(2)} MB'
          : '${kb.toStringAsFixed(2)} KB';
      print('File size: $size');
      final ext = path.extension(pickedPath.path);
      print(ext.split(".").last.toUpperCase());
      controller.pickedFilePathModel.add(PickedFilePathModel(
          filename: pickedPath.path,
          size: size,
          extensionValue: ext.split(".").last.toUpperCase()));
    }
    print(files);

    return controller.pickedFilePathModel;
  } else {}
}

Future<List<String>> pickedFile(BuildContext context) async {
  final ImagePicker picker = ImagePicker();

  final List<XFile> selectedImages = await picker.pickMultiImage();

  List<String> imagePath = [];
  for (var element in selectedImages) {
    imagePath.add(element.path);
  }
  print(imagePath);
  return imagePath;
}

Future<String?> pickImage(
    EditPurchaseScreenController controller, ImageSource imageSource) async {
  try {
    XFile? pickedImageFile = await ImagePicker().pickImage(
      source: imageSource,
      imageQuality: 30,
    );

    if (pickedImageFile != null) {
      print(File(pickedImageFile.path).lengthSync());
      int? fileSize = File(pickedImageFile.path).lengthSync();
      double kb = fileSize / 1024;
      double mb = kb / 1024;
      final size = (mb >= 1)
          ? '${mb.toStringAsFixed(2)} MB'
          : '${kb.toStringAsFixed(2)} KB';
      print('File size: $size');
      final ext = path.extension(pickedImageFile.path);
      print(ext.split(".").last.toUpperCase());
      controller.pickedFilePathModel.add(PickedFilePathModel(
          filename: pickedImageFile.path,
          size: size,
          extensionValue: ext.split(".").last.toUpperCase()));
      return pickedImageFile.path;
    }
    // ignore: empty_catches
  } catch (e) {}
  return null;
}

Future<List> getImageBottomSheet(
    EditPurchaseScreenController controller) async {
  await Get.bottomSheet(
    BottomSheet(
      onClosing: () {},
      builder: (context) => SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.r),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Column(
            children: [
              Text(
                "Please select",
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                children: [
                  const Spacer(),
                  GestureDetector(
                    onTap: () async {
                      await pickMultileFiles(context, controller);

                      Get.back();
                    },
                    child: Container(
                      padding: EdgeInsets.all(15.r),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10.r)),
                      child: Column(
                        children: [
                          Icon(
                            Icons.image,
                            color: Colors.grey,
                            size: 30.r,
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                            "Gallery",
                            style: TextStyle(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () async {
                      await pickImage(controller, ImageSource.camera);

                      Get.back();
                    },
                    child: Container(
                      padding: EdgeInsets.all(15.r),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10.r)),
                      child: Column(
                        children: [
                          Icon(
                            Icons.camera_enhance_rounded,
                            color: Colors.grey,
                            size: 30.r,
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                            "Camera",
                            style: TextStyle(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
            ],
          ),
        ),
      ),
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.r),
    ),
    backgroundColor: Colors.transparent,
  );

  return controller.pickedFilePathModel;
}
