import 'dart:developer';

import 'package:get/get.dart';
import 'package:inventory_client/models/purchase_model.dart';

import '../../apis/purchase/get_purchase_api.dart';

class PurchaseScreenController extends GetxController {
  RxList<PurchaseModel> data = <PurchaseModel>[].obs;

  RxBool isLoading = true.obs;

  getData() async {
    isLoading(true);
    log("getting data..");
    var list = await apiGetPurchases();
    if (list != null) {
      data.clear();
      for (var element in list) {
        data.add(element);
      }
    }
    isLoading(false);
  }
}
