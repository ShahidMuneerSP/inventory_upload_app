import 'package:flutter/material.dart';

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:open_filex/open_filex.dart';

Future<String?> pickedFiles(BuildContext context) async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['doc', 'docx', 'pdf', 'xls', 'xlsx', 'jpg']);
  if (result != null) {
    File file = File(result.files.single.path!);

    print(file.toString());
  } else {
    return null;
  }

  final file = result.files.first;
  _openFile(file);
  return result.files.first.path;
}

void _openFile(PlatformFile file) {
  OpenFilex.open(file.path);
}
