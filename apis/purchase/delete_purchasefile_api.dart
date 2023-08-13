// ignore_for_file: non_constant_identifier_names

import 'dart:developer';

import 'package:inventory_client/constants/api_constants.dart';
import 'package:http/http.dart' as http;
import 'package:inventory_client/constants/user_credentials.dart';

Future<bool> deletePurchaseFileApi(String fileID) async {
  try {
    print("started upload ??");
    final url = Uri.parse(
        "${ApiConstants.BASE_URL}${ApiConstants.DELETE_PURCHASE_FILE}/$fileID/$userId");
    log(fileID.toString());
    log(userId.toString());

    var response = await http.delete(url);

    log(response.body);

    if (response.statusCode == 200) {
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
