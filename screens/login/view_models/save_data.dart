import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:inventory_client/constants/user_credentials.dart';

Future<bool> saveData(Map data) async {
  try {
    const storage = FlutterSecureStorage();

    userId = data["id"];
    companyId = data["company_id"];
    name = data["name"];
    email = data["email"];
    userType = data["user_type_id"];
    isActive = data["is_active"];

    await storage.write(key: "userId", value: userId);
    await storage.write(key: "companyId", value: companyId);
    await storage.write(key: "name", value: name);
    await storage.write(key: "email", value: email);
    await storage.write(key: "userType", value: userType.toString());
    await storage.write(key: "isActive", value: isActive.toString());

    return true;
  } catch (e) {
    log(e.toString());
    return false;
  }
}
