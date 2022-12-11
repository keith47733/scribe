import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../constants/constants.dart';
import 'user_auth_screen/create_scribe_form.dart';
import 'user_auth_screen/login_scribe_form.dart';

class ScribeAuthScreen extends StatefulWidget {
  const ScribeAuthScreen({super.key});

  @override
  State<ScribeAuthScreen> createState() => _ScribeAuthScreenState();
}

class _ScribeAuthScreenState extends State<ScribeAuthScreen> {
  bool _isLogin = true;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _header(context),
          _isLogin ? const LoginScribeForm() : const CreateScribeForm(),
          const SizedBox(height: SPACING),
          _formTextButton(context),
          const SizedBox(height: SPACING),
          _footer(context),
        ],
      ),
    );
  }

  Widget _header(context) {
    return Expanded(
      flex: 2,
      child: Container(
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
    );
  }

  Widget _formTextButton(context) {
    return Center(
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: _isLogin
                  ? 'Don\'t have an account?'
                  : 'Already have an account?',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
            const TextSpan(text: '  '),
            TextSpan(
              text: _isLogin ? 'Create Account' : 'Login',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  setState(() {
                    _isLogin = !_isLogin;
                  });
                },
            ),
          ],
        ),
      ),
    );
  }

  Widget _footer(context) {
    return Expanded(
      flex: 2,
      child: Container(
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
    );
  }
}