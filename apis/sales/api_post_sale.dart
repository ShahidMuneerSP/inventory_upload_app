import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'dart:async';
import 'dart:io';

import 'package:inventory_client/constants/api_constants.dart';

Future<bool> apipostSale(
  List<File> files,
  Title,
  InvoiceNo,
  Description,
  UserId,
) async {
  try {
    final url = Uri.parse(ApiConstants.BASE_URL + ApiConstants.ADD_SALES_URL);
    Map<String, String> headers = {'Content-Type': 'application/json'};
    var request = http.MultipartRequest('POST', url);
    Map<String, String> msg = {
      'userId': UserId.toString(),
      "title": Title.toString(),
      "file[]": files.toString(),
      "invoice_no": InvoiceNo.toString(),
      "description": Description.toString(),
    };

    for (var i = 0; i < files.length; i++) {
      var file = files[i];
      var multipartFile = await http.MultipartFile.fromPath(
          'files[]', file.path,
          contentType: MediaType("file", "pdf"));
      request.files.add(multipartFile);
    }
    request.headers.addAll(headers);
    var response = await request.send();
    if (response.statusCode == 200) {
      print('Files uploaded successfully!');
      return true;
    } else {
      print('Failed to upload files');
    }
  } catch (e) {
    print("Exception occured");
    log(e.toString());
  }
  return false;
}
