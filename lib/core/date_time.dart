import 'package:intl/intl.dart';

extension OnDateTime on DateTime {
  String get timeOnly => DateFormat('hh:mm a').format(this);
  String get dateOnly => DateFormat('yyyy-MM-dd').format(this);
  String get timeAndDate => DateFormat('yyyy-MM-dd hh:mm a').format(this);
  String get monthAndDay => DateFormat('dd MMM').format(this);
  String get yearMonthDay => DateFormat('dd MMM yyyy').format(this);
  String get birthDateForm => DateFormat('dd/MM/yyyy').format(this);
}

extension OnString on String {
  DateTime get _datetime => DateTime.tryParse(this) ?? DateTime.now();
  String get timeOnly => DateFormat('hh:mm a').format(_datetime);
  String get dateOnly => DateFormat('yyyy-MM-dd').format(_datetime);
  String get timeAndDate => DateFormat('yyyy-MM-dd hh:mm a').format(_datetime);
  String get monthAndDay => DateFormat('dd MMM').format(_datetime);
  String get yearMonthDay => DateFormat('dd MMM yyyy').format(_datetime);
  String get birthDateForm => DateFormat('dd/MM/yyyy').format(_datetime);
}
