import 'package:intl/intl.dart';

extension DateExtention on DateTime {
  String get timeOnly => DateFormat("hh:mm").format(this);
}
