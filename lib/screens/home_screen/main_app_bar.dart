import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../variables/constants.dart';
import '../scribe_auth_screen.dart';
import 'sort_switch.dart';
import 'scribe_avatar.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({super.key});

  @override
  final Size preferredSize = const Size(double.infinity, APP_BAR_HEIGHT);

  void _logout(context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (ctx) => const ScribeAuthScreen(),
        ),
      );
    } catch (error) {
      print('LOGOUT ERROR: ${error.toString()}');
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: preferredSize.height,
      elevation: APP_BAR_ELEVATION,
      backgroundColor: Theme.of(context).colorScheme.primary,
      title: _logoTitle(context),
      actions: [
        const SortSwitch(),
        const SizedBox(width: SPACING * 1.5),
        const ScribeAvatar(),
        const SizedBox(width: SPACING * 1.5),
        _logoutButton(context),
        const SizedBox(width: SPACING * 1.5),
      ],
    );
  }

  Widget _logoTitle(context) {
    return Row(
      children: [
        const SizedBox(width: SPACING),
        _logo(context),
        const SizedBox(width: SPACING / 2),
        _title(context),
        const SizedBox(width: SPACING),
      ],
    );
  }

  Widget _logo(context) {
    return SizedBox(
      height: APP_BAR_HEIGHT * 0.85,
      width: APP_BAR_HEIGHT * 0.85,
      child: Image.asset(
        'assets/images/grimoire.png',
        color: Theme.of(context).colorScheme.onPrimary,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _title(context) {
    return Text(
      'Grimoire',
      style: Theme.of(context).textTheme.headlineLarge!.copyWith(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
    );
  }

  Widget _logoutButton(context) {
    return IconButton(
      onPressed: () => _logout(context),
      icon: Icon(
        Icons.logout,
        color: Theme.of(context).colorScheme.onPrimary,
        size: APP_BAR_HEIGHT * 0.30,
      ),
    );
  }
}
