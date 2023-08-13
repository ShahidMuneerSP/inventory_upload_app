import 'package:get/state_manager.dart';

class AddEditInventoryScreenController extends GetxController {
  RxList<PickedFilePathModel> pickedFilePathModel = <PickedFilePathModel>[].obs;
}

class PickedFilePathModel {
  String? filename;
  String? size;
  String? extensionValue;
  PickedFilePathModel(
      {required this.filename,
      required this.size,
      required this.extensionValue});
}
