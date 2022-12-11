// import 'dart:core';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../variables/constants.dart';
import '../../variables/global.dart';

class DatePicker extends StatelessWidget {
  const DatePicker({super.key});

  @override
  Widget build(BuildContext context) {
    print('DATE PICKER: ${selectedDate.toString()}');
    return Padding(
      padding: const EdgeInsets.only(top: SPACING / 2),
      child: SfDateRangePicker(
        onSelectionChanged: (selection) {
          selectedDate = selection.value;
          print('DATE PICKER AFTER SELECTION: ${selectedDate.toString()}');
        },
      ),
    );
  }
}
