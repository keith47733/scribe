import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

String formatDateFromDateTime(DateTime date) {
  return DateFormat.EEEE().add_yMMMMd().format(date);
}

String formatDateFromTimestamp(Timestamp timestamp) {
  return DateFormat.EEEE().add_yMMMMd().format(timestamp.toDate());
}

String formatTimeFromTimestamp(Timestamp timestamp) {
  return DateFormat.jm().format(timestamp.toDate());
}
