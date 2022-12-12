import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/grimoire.dart';

class SortSwitch extends StatefulWidget {
  const SortSwitch({super.key});

  @override
  State<SortSwitch> createState() => _SortSwitchState();
}

class _SortSwitchState extends State<SortSwitch> {
  bool? sortLatest;

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
    return Consumer<Grimoire>(
      builder: (context, grimoire, _) {
        grimoire.sortLatest == null
            ? sortLatest = true
            : sortLatest = grimoire.sortLatest!;
        return Switch(
          activeColor: Theme.of(context).colorScheme.tertiaryContainer,
          inactiveThumbColor: Theme.of(context).colorScheme.tertiaryContainer,
          value: sortLatest!,
          onChanged: (value) {
            setState(() {
              sortLatest = value;
              grimoire.sortLatest = value;
            });
          },
        );
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
