import 'dart:developer';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:open_filex/open_filex.dart';
import '../../../../common/widgets/custom_snackbar.dart';
import '../../../common/widgets/custom_progressIndicator.dart';

openFile(String url) async {
  log(url);
  CustomProgressIndicator.openProgress(text: "Opening file..");

  try {
    var file = await DefaultCacheManager().getSingleFile(url);

    var filePath = file.path;
    final result = await OpenFilex.open(filePath);

    return result;
  } catch (e) {
    log(e.toString());
    customSnackBar("Oops..!", "File not found..");
  } finally {
    CustomProgressIndicator.closeProgress();
  }
}
