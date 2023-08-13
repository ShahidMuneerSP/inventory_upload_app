import 'dart:developer';

import 'package:get/get.dart';
import 'package:inventory_client/models/inventory_model.dart';

import '../../apis/list_inventory/get_list_inventory_api.dart';

class ListInventoryScreenController extends GetxController {
  RxList<InventoryModel> data = <InventoryModel>[].obs;

  RxBool isLoading = true.obs;

  getData() async {
    isLoading(true);
    log("getting data..");

    var list = await apiGetListInventory();

    if (list != null) {
      data.clear();
      for (var element in list) {
        data.add(element);
      }
    }

    isLoading(false);
  }
}
