import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:inventory_client/constants/user_credentials.dart';

Future<bool> getAlldata() async {
  const storage = FlutterSecureStorage();

  userId = await storage.read(key: "userId");
  companyId = await storage.read(key: "companyId");
  name = await storage.read(key: "name");
  email = await storage.read(key: "email");
  userType = int.parse(await storage.read(key: "userType") ?? "0");
  isActive = int.parse(await storage.read(key: "isActive") ?? "0");

  if (userId != null) {
    return true;
  } else {
    return false;
  }
}
