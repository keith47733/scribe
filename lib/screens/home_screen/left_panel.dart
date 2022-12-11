import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../add_page/add_page_dialog.dart';
import 'date_picker.dart';

class LeftPanel extends StatelessWidget {
  const LeftPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Expanded(
      flex: 1,
      child: Container(
        height: size.height,
        decoration: const BoxDecoration(
          shape: BoxShape.rectangle,
          border: Border(
            right: BorderSide(width: 0.4),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(SPACING),
          child: Column(
            children: [
              const DatePicker(),
              _cardButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _cardButton(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: SPACING),
      child: Card(
        elevation: CARD_ELEVATION,
        color: Theme.of(context).colorScheme.primary,
        child: Padding(
          padding: const EdgeInsets.all(SPACING / 3),
          child: TextButton.icon(
            onPressed: () {
              showDialog(
                context: context,
                barrierDismissible: true,
                builder: (context) {
                  return const AddPageDialog();
                },
              );
            },
            icon: Icon(
              Icons.bookmark_add_outlined,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            label: FittedBox(
              child: Text(
                'New Page',
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
