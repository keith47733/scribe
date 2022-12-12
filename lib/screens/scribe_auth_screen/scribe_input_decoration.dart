import 'package:flutter/material.dart';

import '../../variables/constants.dart';

InputDecoration scribeInputDecoration(context, label, hint) {
  return InputDecoration(
    fillColor: Theme.of(context).colorScheme.surface,
    floatingLabelBehavior: FloatingLabelBehavior.always,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(RADIUS * 2),
      borderSide: BorderSide(
        color: Theme.of(context).colorScheme.primary,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(RADIUS * 2),
      borderSide: BorderSide(
        color: Theme.of(context).colorScheme.primary,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(RADIUS * 2),
      borderSide: BorderSide(
        color: Theme.of(context).colorScheme.errorContainer,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(RADIUS * 2),
      borderSide: BorderSide(
        color: Theme.of(context).colorScheme.error,
      ),
    ),
    labelText: label,
    labelStyle: Theme.of(context).textTheme.labelLarge!.copyWith(
          color: Theme.of(context).colorScheme.primary,
        ),
    hintText: hint,
    hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
          color: Theme.of(context).colorScheme.outline,
        ),
  );
}
