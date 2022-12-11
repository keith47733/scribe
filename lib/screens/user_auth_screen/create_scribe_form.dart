import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../variables/constants.dart';
import '../../services/scribe_services.dart';
import '../home_screen.dart';
import 'auth_input_decoration.dart';

class CreateScribeForm extends StatefulWidget {
  const CreateScribeForm({
    super.key,
  });

  @override
  State<CreateScribeForm> createState() => _CreateScribeFormState();
}

class _CreateScribeFormState extends State<CreateScribeForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void _createAccount(context) async {
    try {
      setState(() {
        _isLoading = true;
      });
      await Future.delayed(const Duration(seconds: 2));

      final isValid = _formKey.currentState!.validate();

      if (!isValid) {
        throw Exception('Form not validated');
      }

      UserCredential auth;
      final scribeEmail = _emailController.text.trim();
      final scribePassword = _passwordController.text.trim();

      auth = await ScribeServices().createScribe(scribeEmail, scribePassword);

      if (auth.user == null) {
        throw Exception('Created user is NULL');
      }

      await ScribeServices().addScribe(
        context,
        auth.user!.uid,
        scribeEmail.split('@')[0],
        'https://lh3.googleusercontent.com/a/AEdFTp6W3XMclYVKR47kNz55HeVd9VjUZFkGuYgU0Titfu8=s96-c',
        'Musician',
      );

      auth = await ScribeServices().loginScribe(scribeEmail, scribePassword);

      if (auth.user == null) {
        throw Exception('Login user is NULL');
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
      print('CREATE USER ERROR: ${error.toString()}');
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
          _createAccountMessage(context),
          const SizedBox(height: SPACING * 1.5),
          _emailFormField(context, size),
          const SizedBox(height: SPACING * 1.5),
          _passwordFormField(context, size),
          const SizedBox(height: SPACING * 1.5),
          _isLoading
              ? Center(
                  child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ))
              : _createAccountButton(context),
        ],
      ),
    );
  }

  Widget _title(context) {
    return Text(
      'Create Account',
      style: Theme.of(context).textTheme.displaySmall!.copyWith(
            color: Theme.of(context).colorScheme.primary,
          ),
    );
  }

  Widget _createAccountMessage(context) {
    return Text(
      'Please enter a valid email and a password that is at least 6 characters.',
      style: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
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

  Widget _createAccountButton(context) {
    return ElevatedButton(
      onPressed: () => _createAccount(context),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(SPACING),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      child: FittedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Icon(
              Icons.person_add,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            const SizedBox(width: SPACING / 2),
            Text(
              'Submit',
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
