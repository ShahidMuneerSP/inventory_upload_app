import 'dart:developer';

import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

Future<String> getImage(BuildContext context) async {
  XFile? pickedImageFile = await ImagePicker().pickImage(
    source: ImageSource.camera,
    imageQuality: 50,
  );
  if (pickedImageFile != null) {
    log(pickedImageFile.path.toString());
    return pickedImageFile.path;
  } else {
    return "";
  }
}
