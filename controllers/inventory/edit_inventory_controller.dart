import 'package:get/state_manager.dart';

class EditInventoryScreenController extends GetxController {
  RxList<PickedFilePathModel> pickedUrlPathModel = <PickedFilePathModel>[].obs;
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
