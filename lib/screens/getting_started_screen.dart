import 'package:flutter/material.dart';

import '../constants/constants.dart';
import 'scribe_auth_screen.dart';

class GettingStartedScreen extends StatelessWidget {
  const GettingStartedScreen({super.key});

  void _gotoLoginScreen(context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const ScribeAuthScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(SPACING * 2),
        child: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          child: FittedBox(
            clipBehavior: Clip.none,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _title(context),
                // const SizedBox(height: SPACING / 2),
                _tagLine(context),
                const SizedBox(height: SPACING),
                _titleImage(context, size),
                const SizedBox(height: SPACING * 2),
                _getStartedButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _title(context) {
    return Text(
      'Grimoire',
      style: Theme.of(context).textTheme.headlineLarge!.copyWith(
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
    );
  }

  Widget _tagLine(context) {
    return Text(
      'Document your life!',
      style: Theme.of(context).textTheme.headlineMedium!.copyWith(
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
    );
  }

  Widget _titleImage(context, size) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(RADIUS * 3),
      child: Image.asset(
        'assets/images/getting_started.jpg',
        height: size.height * 0.33,
      ),
    );
  }

  Widget _getStartedButton(context) {
    return ElevatedButton(
      onPressed: () => _gotoLoginScreen(context),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(SPACING),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      child: Text(
        'Get Started!',
        style: Theme.of(context).textTheme.labelLarge!.copyWith(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
      ),
    );
  }
}
