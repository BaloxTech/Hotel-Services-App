import 'package:intl/intl.dart';

String getDate(DateTime date) => DateFormat('yyyy-MM-dd hh:mm a').format(date);
