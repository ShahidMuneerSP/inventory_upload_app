// ignore_for_file: non_constant_identifier_names

import 'dart:developer';
import 'dart:io';

import 'package:inventory_client/constants/api_constants.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

Future<bool> addInventoryApi(
    {context,
    Title,
    InvoiceNo,
    Description,
    UserId,
    required List images}) async {
  try {
    print("started upload ??");
    final url =
        Uri.parse(ApiConstants.BASE_URL + ApiConstants.Add_INVENTORY_URL);

    Map<String, String> headers = {'Content-Type': 'application/json'};
    var request = http.MultipartRequest(
      "POST",
      url,
    );

    Map<String, String> msg = {
      'userId': UserId.toString(),
      "title": Title.toString(),
      "file[]": images.toString(),
      "invoice_no": InvoiceNo.toString(),
      "description": Description.toString(),
    };

    request.headers.addAll(headers);
    request.fields.addAll(msg);

    log(request.files.toString());

    addFiles(File fileData) async {
      request.files.add(
        http.MultipartFile(
          'file[]',
          fileData.readAsBytes().asStream(),
          await fileData.length(),
          filename: fileData.path.split("/").last,
          contentType: MediaType('file', 'pdf'),
        ),
      );
    }

    images.forEach((element) async {
      File fileData = File(element.filename);

      log(fileData.path.split("/").last);
      await addFiles(fileData);
    });
    log(request.fields.toString());

    var response = await request.send();
    var res = await response.stream.bytesToString();
    log(res.toString());

    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Successfully Added");
      return true;
    } else {
      print("Error while posting data");
    }
  } catch (e) {
    print("Exception occured");
    log(e.toString());
  }
  return false;
}
