import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class AddRightPanel extends StatelessWidget {
  const AddRightPanel({
    super.key,
    required this.addParchmentFunction,
    required this.isLoading,
  });

  final VoidCallback addParchmentFunction;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _discardButton(context),
          const SizedBox(width: SPACING),
          _doneButton(context),
        ],
      ),
    );
  }

  Widget _discardButton(context) {
    return TextButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(SPACING),
      ),
      child: Text(
        'Discard',
        style: Theme.of(context).textTheme.labelLarge!.copyWith(
              color: Theme.of(context).colorScheme.secondary,
            ),
      ),
    );
  }

  Widget _doneButton(context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : ElevatedButton(
            onPressed: addParchmentFunction,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(SPACING),
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
            child: Text(
              'Done',
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
            ),
          );
  }
}
