import 'package:intl/intl.dart';

extension DateTimeUtils on DateTime {
  String format([String pattren = 'y-M-d']) => DateFormat(pattren).format(this);
}
