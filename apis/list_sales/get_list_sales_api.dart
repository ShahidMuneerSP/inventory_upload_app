import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:inventory_client/constants/user_credentials.dart';
import '../../common/widgets/custom_snackbar.dart';
import '../../constants/api_constants.dart';
import '../../models/sales_model.dart';

Future<List<SalesModel>?> apiGetListSales() async {
  try {
    var url = Uri.parse(
        "${ApiConstants.BASE_URL}${ApiConstants.GET_LISTSALES_URL}/$userId/$companyId");

    var response = await http.get(
      url,
    );
    log(userId.toString());
    log(companyId.toString());
    log(response.body);

    if (response.statusCode == 200) {
      List resultData = jsonDecode(response.body)["sales"];
      List<SalesModel> salesList = [];

      ///insert api data to a list
      for (var element in resultData) {
        salesList.add(SalesModel.fromJson(element));
      }

      return salesList;
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
