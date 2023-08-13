import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:inventory_client/constants/user_credentials.dart';

import '../../common/widgets/custom_snackbar.dart';
import '../../constants/api_constants.dart';
import '../../models/inventory_model.dart';

Future<List<InventoryModel>?> apiGetInventory() async {
  try {
    var url = Uri.parse(
        "${ApiConstants.BASE_URL}${ApiConstants.GET_INVENTORY_URL}/$userId");

    var response = await http.get(
      url,
    );
    log(response.body);

    if (response.statusCode == 200) {
      List resultData = jsonDecode(response.body)["inventory"];
      List<InventoryModel> inventory = [];
      for (var element in resultData) {
        inventory.add(InventoryModel.fromJson(element));
      }

      return inventory;
    } else {}
  } catch (e) {
    if (e.toString().contains('Connection failed')) {
      customSnackBar('Network Error',
          'Please check your internet connection and try again..');
    } else {
      customSnackBar('Error', 'Something went wrong..');
    }

    print(e.toString());
  }

  return null;
}
