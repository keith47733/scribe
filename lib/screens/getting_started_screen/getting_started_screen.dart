import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../user_auth_screen/user_auth_screen.dart';

class GettingStartedScreen extends StatelessWidget {
  const GettingStartedScreen({super.key});

  void _gotoLoginScreen(context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const UserAuthScreen(),
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
                const SizedBox(height: SPACING),
                _tagLine(context),
                const SizedBox(height: SPACING * 2),
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
      'Scribe',
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
    return Image.asset(
      'assets/images/scribe.png',
      height: size.height * 0.33,
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
