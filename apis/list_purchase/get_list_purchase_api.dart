import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:inventory_client/constants/user_credentials.dart';
import 'package:inventory_client/models/purchase_model.dart';
import '../../common/widgets/custom_snackbar.dart';
import '../../constants/api_constants.dart';

Future<List<PurchaseModel>?> apiGetListPurchase() async {
  try {
    var url = Uri.parse(
        "${ApiConstants.BASE_URL}${ApiConstants.GET_LISTPURCHASE_URL}/$userId/$companyId");

    var response = await http.get(
      url,
    );
    log(response.body);

    if (response.statusCode == 200) {
      List resultData = jsonDecode(response.body)["purchases"];
      List<PurchaseModel> purchaseList = [];

      ///insert api data to a list
      for (var element in resultData) {
        purchaseList.add(PurchaseModel.fromJson(element));
      }

      return purchaseList;
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
