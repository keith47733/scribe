import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/scribe.dart';
import '../../variables/constants.dart';
import '../home_screen.dart';
import 'scribe_input_decoration.dart';

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

  void _createScribe(context) async {
    try {
      setState(() {
        _isLoading = true;
      });

      final String email = _emailController.text.trim();
      final String password = _passwordController.text.trim();

      final isValid = _formKey.currentState!.validate();
      if (!isValid) {
        throw Exception('Form not validated');
      }

      final bool isCreate = await Provider.of<Scribe>(context, listen: false)
          .createScribe(email, password);

      if (!isCreate) {
        throw Exception('isCreate is FALSE');
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
              : _createScribeButton(context),
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
              scribeInputDecoration(context, 'Email', 'johndoe@gmail.com'),
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
        decoration: scribeInputDecoration(
            context, 'Password', 'Enter a secure password'),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a password.';
          }
          return null;
        },
      ),
    );
  }

  Widget _createScribeButton(context) {
    return ElevatedButton(
      onPressed: () => _createScribe(context),
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
