import 'dart:developer';

import 'package:get/get.dart';
import 'package:inventory_client/apis/inventory/get_inventory_api.dart';
import 'package:inventory_client/models/inventory_model.dart';

class InventoryScreenController extends GetxController {
  RxList<InventoryModel> data = <InventoryModel>[].obs;

  RxBool isLoading = true.obs;

  getData() async {
    isLoading(true);
    log("getting data..");

    var list = await apiGetInventory();

    if (list != null) {
      data.clear();
      for (var element in list) {
        data.add(element);
      }
    }

    isLoading(false);
  }
}
