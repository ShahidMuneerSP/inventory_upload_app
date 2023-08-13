import 'dart:developer';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';

urlToFile(String url) async {
  log(url);

  try {
    var file = await DefaultCacheManager().getSingleFile(url);

    var filePath = file.path;

    return filePath;
  } catch (e) {
    log(e.toString());
  }
}
