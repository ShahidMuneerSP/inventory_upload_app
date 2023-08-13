// ignore_for_file: non_constant_identifier_names

import 'dart:developer';

import 'package:inventory_client/constants/api_constants.dart';
import 'package:http/http.dart' as http;
import 'package:inventory_client/constants/user_credentials.dart';

import '../../screens/sales/sales_screen.dart';

Future<bool> deleteSaleApi(String id) async {
  try {
    print("started upload ??");
    final url = Uri.parse(
        "${ApiConstants.BASE_URL}${ApiConstants.DELETE_SALE_URL}/$id/$userId");

    var response = await http.delete(url);

    log(response.body);

    if (response.statusCode == 200) {
      salesScreenController.getData();
      print("Successfully Deleted");
      return true;
    } else {
      print("Error while deleting data");
    }
  } catch (e) {
    print("Exception occured");
    log(e.toString());
  }
  return false;
}
