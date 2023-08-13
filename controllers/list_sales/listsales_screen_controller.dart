import 'dart:developer';

import 'package:get/get.dart';
import 'package:inventory_client/models/sales_model.dart';

import '../../apis/list_sales/get_list_sales_api.dart';

class ListSalesScreenController extends GetxController {
  RxList<SalesModel> data = <SalesModel>[].obs;

  RxBool isLoading = true.obs;

  getData() async {
    isLoading(true);
    log("getting data..");

    var list = await apiGetListSales();

    if (list != null) {
      data.clear();
      for (var element in list) {
        data.add(element);
      }
    }

    isLoading(false);
  }
}
