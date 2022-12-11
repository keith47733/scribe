import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../../services/scribe_services.dart';
import '../home_screen.dart';
import 'auth_input_decoration.dart';

class LoginScribeForm extends StatefulWidget {
  const LoginScribeForm({
    super.key,
  });

  @override
  State<LoginScribeForm> createState() => _LoginScribeFormState();
}

class _LoginScribeFormState extends State<LoginScribeForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _emailController.text = 'a@a.com';
    _passwordController.text = '123456';
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void _login(context) async {
    try {
      setState(() {
        _isLoading = true;
      });
      // await Future.delayed(const Duration(seconds: 2));

      final isValid = _formKey.currentState!.validate();

      if (!isValid) {
        throw Exception('Form not validated');
      }

      UserCredential auth;
      final scribeEmail = _emailController.text.trim();
      final scribePassword = _passwordController.text.trim();

      auth = await ScribeServices().loginScribe(scribeEmail, scribePassword);

      if (auth.user == null) {
        throw Exception('Error logging in user');
      }

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (ctx) => const HomeScreen(),
        ),
      );
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      print('LOGIN ERROR: ${error.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _title(context),
          const SizedBox(height: SPACING),
          _emailFormField(context, size),
          const SizedBox(height: SPACING * 1.5),
          _passwordFormField(context, size),
          const SizedBox(height: SPACING * 1.5),
          _isLoading
              ? Center(
                  child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ))
              : _loginButton(context),
        ],
      ),
    );
  }

  Widget _title(context) {
    return Text(
      'Sign In',
      style: Theme.of(context).textTheme.displaySmall!.copyWith(
            color: Theme.of(context).colorScheme.primary,
          ),
    );
  }

  Widget _emailFormField(context, size) {
    return SizedBox(
      width: size.width * 0.25,
      child: TextFormField(
          controller: _emailController,
          autofocus: true,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
          decoration:
              authInputDecoration(context, 'Email', 'johndoe@gmail.com'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your email address.';
            }
            return null;
          }),
    );
  }

  Widget _passwordFormField(context, size) {
    return SizedBox(
      width: size.width * 0.25,
      child: TextFormField(
        controller: _passwordController,
        obscureText: true,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
        decoration:
            authInputDecoration(context, 'Password', 'Enter a secure password'),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a password.';
          }
          return null;
        },
      ),
    );
  }

  Widget _loginButton(context) {
    return ElevatedButton(
      onPressed: () => _login(context),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(SPACING),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      child: Text(
        'Login',
        style: Theme.of(context).textTheme.labelLarge!.copyWith(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
      ),
    );
  }
}
