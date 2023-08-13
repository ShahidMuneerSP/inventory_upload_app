import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:inventory_client/constants/user_credentials.dart';
import 'package:inventory_client/models/inventory_model.dart';
import '../../common/widgets/custom_snackbar.dart';
import '../../constants/api_constants.dart';

Future<List<InventoryModel>?> apiGetListInventory() async {
  try {
    var url = Uri.parse(
        "${ApiConstants.BASE_URL}${ApiConstants.GET_LISTINVENTORY_URL}/$userId/$companyId");

    var response = await http.get(
      url,
    );
   
    log(response.body);

    if (response.statusCode == 200) {
      List resultData = jsonDecode(response.body)["inventory"];
      List<InventoryModel> inventoryList = [];

      ///insert api data to a list
      for (var element in resultData) {
        inventoryList.add(InventoryModel.fromJson(element));
      }

      return inventoryList;
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
