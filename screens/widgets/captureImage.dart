import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// ignore: body_might_complete_normally_nullable
captureFromCamara(BuildContext context) async {
  try {
    XFile? selectedImage = await ImagePicker()
        .pickImage(source: ImageSource.camera, maxHeight: 100, maxWidth: 100);

    if (selectedImage != null) {
      File imageFile = File(selectedImage.path);

      print(imageFile.toString());
    } else {
      return null;
    }
  } catch (errorMsg) {
    print(errorMsg.toString());
  }
}
