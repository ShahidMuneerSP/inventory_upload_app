import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../common/widgets/custom_snackbar.dart';
import '../../constants/api_constants.dart';

Future<Map?> apiLogin(
    {required String username, required String password}) async {
  log(username);
  log(password);
  try {
    var url = Uri.parse(ApiConstants.BASE_URL + ApiConstants.LOGIN_URL);
    Map<String, String> headers = {'Content-Type': 'application/json'};
    final msg = jsonEncode({
      "username": username,
      "password": password,
    });
    var response = await http.post(
      url,
      headers: headers,
      body: msg,
    );

    log(url.toString());

    log(response.body);
    Map data = jsonDecode(response.body);

    if (response.statusCode == 200 && data["status"] == 200) {
      return data["user"];
    } else {
      customSnackBar("Oops..!", data["message"]);
    }
  } catch (e) {
    Get.back();
    if (e.toString().contains('Network is')) {
      customSnackBar(
          'Network Error', 'Please connect to the internet and try again');
    } else {
      customSnackBar('Error', 'Something went wrong..');
    }

    log(e.toString());
  }
  return null;
}
