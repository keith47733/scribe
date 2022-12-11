import 'package:flutter/material.dart';

InputDecoration parchmentInputDecoration(context, hint) {
  return InputDecoration(
    fillColor: Theme.of(context).colorScheme.surface,
    hintText: hint,
    hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
          color: Theme.of(context).colorScheme.outline,
        ),
  );
}
