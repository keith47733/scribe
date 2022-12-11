import 'package:flutter/material.dart';

class SortSwitch extends StatefulWidget {
  const SortSwitch({super.key});

  @override
  State<SortSwitch> createState() => _SortSwitchState();
}

class _SortSwitchState extends State<SortSwitch> {
  bool isLatest = true;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _earliest(),
        _switch(),
        _latest(),
      ],
    );
  }

  Widget _earliest() {
    return Text(
      'Earliest',
      style: Theme.of(context).textTheme.bodySmall!.copyWith(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
    );
  }

  Widget _switch() {
    return Switch(
      activeColor: Theme.of(context).colorScheme.tertiaryContainer,
      inactiveThumbColor: Theme.of(context).colorScheme.tertiaryContainer,
      value: isLatest,
      onChanged: (value) {
        setState(() {
          isLatest = value;
        });
      },
    );
  }

  Widget _latest() {
    return Text(
      'Latest',
      style: Theme.of(context).textTheme.bodySmall!.copyWith(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
    );
  }
}
