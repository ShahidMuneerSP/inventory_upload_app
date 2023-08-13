import 'dart:developer';

import 'package:get/get.dart';

import 'package:inventory_client/models/sales_model.dart';

import '../../apis/sales/get_sales_api.dart';

class SalesScreenController extends GetxController {
  RxList<SalesModel> data = <SalesModel>[].obs;

  RxBool isLoading = true.obs;

  getData() async {
    isLoading(true);
    log("getting data..");

    var list = await apiGetSales();

    if (list != null) {
      data.clear();
      for (var element in list) {
        data.add(element);
      }
    }

    isLoading(false);
  }
}
