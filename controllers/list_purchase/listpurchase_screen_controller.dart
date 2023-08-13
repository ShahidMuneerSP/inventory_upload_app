import 'dart:developer';

import 'package:get/get.dart';
import 'package:inventory_client/models/purchase_model.dart';
import '../../apis/list_purchase/get_list_purchase_api.dart';

class ListPurchaseScreenController extends GetxController {
  RxList<PurchaseModel> newdata = <PurchaseModel>[].obs;

  RxBool isLoading = true.obs;

  getData() async {
    isLoading(true);
    log("getting data..");

    var list = await apiGetListPurchase();

    if (list != null) {
      newdata.clear();
      for (var element in list) {
        newdata.add(element);
      }
    }

    isLoading(false);
  }
}
