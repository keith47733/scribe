import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../constants/constants.dart';

class DatePicker extends StatelessWidget {
  const DatePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: SPACING / 2),
      child: SfDateRangePicker(
        onSelectionChanged: (selection) {
          print(selection.value.toString());
        },
      ),
    );
  }
}
