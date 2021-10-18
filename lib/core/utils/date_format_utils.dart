import 'package:intl/intl.dart';

String dateFormatyyyyMMddToddMMyyyy(String date) =>
    DateFormat('dd/MM/yyyy').format(DateTime.parse(date));
