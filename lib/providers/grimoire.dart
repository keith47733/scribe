import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Grimoire with ChangeNotifier {
  DateTime? _selectedDate;
  bool? _sortLatest;

  final CollectionReference parchmentRef =
      FirebaseFirestore.instance.collection('parchments');

  DateTime? get selectedDate {
    if (_selectedDate == null) {
      return null;
    }
    return _selectedDate!;
  }

  bool? get sortLatest {
    if (_sortLatest == null) {
      return null;
    }
    return _sortLatest;
  }

  set selectedDate(date) {
    _selectedDate = date;
    notifyListeners();
  }

  set sortLatest(sort) {
    _sortLatest = sort;
    notifyListeners();
  }

  void resetSortParameters() {
    _selectedDate = null;
    _sortLatest = null;
  }
}
