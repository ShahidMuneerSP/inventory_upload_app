// import 'package:intl/intl.dart';

///this is to convert timeformat utc to local
///

DateTime utcToLocal(String dateTime) {
  DateTime d = DateTime.parse(dateTime).toLocal();

  return d;
}
