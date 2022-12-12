import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../providers/grimoire.dart';
import '../../variables/constants.dart';

class DatePicker extends StatelessWidget {
  const DatePicker({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime? selectedDate;
    return Consumer<Grimoire>(
      builder: (context, grimoire, _) {
        selectedDate = grimoire.selectedDate;
        grimoire.sortLatest == null
            ? selectedDate = DateTime.now()
            : selectedDate = grimoire.selectedDate;
        return Padding(
          padding: const EdgeInsets.only(top: SPACING / 2),
          child: SfDateRangePicker(
            initialSelectedDate: selectedDate,
            onSelectionChanged: (date) {
              selectedDate = date.value;
              grimoire.selectedDate = selectedDate;
            },
          ),
        );
      },
    );
  }
}
