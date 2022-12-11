import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../../models/grimoire.dart';
import 'page_input_decoration.dart';

class AddPageDialog extends StatefulWidget {
  const AddPageDialog({super.key});

  @override
  State<AddPageDialog> createState() => _AddPageDialogState();
}

class _AddPageDialogState extends State<AddPageDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _scribingController = TextEditingController();

  bool _isLoading = false;

  Future<void> addPage() async {
    try {
      setState(() {
        _isLoading = true;
      });
      await Future.delayed(const Duration(seconds: 2));

      final isValid = _formKey.currentState!.validate();

      if (!isValid) {
        throw Exception('Form not validated');
      }

      await FirebaseFirestore.instance.collection('pages').add(
            Grimoire(
              pageId: '',
              userId: FirebaseAuth.instance.currentUser!.uid,
              author: 'Keith',
              created: Timestamp.fromDate(DateTime.now()),
              photoUrls: 'photo url',
              title: _titleController.text.trim(),
              content: _scribingController.text.trim(),
            ).toMap(),
          );
    } catch (error) {
      print('SAVE PAGE ERROR: ${error.toString()}');
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AlertDialog(
      elevation: CARD_ELEVATION * 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(RADIUS / 2),
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      contentPadding: const EdgeInsets.all(SPACING),
      content: SizedBox(
        height: size.height * 0.85,
        width: size.width * 0.85,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _leftPanel(context),
            _centerPanel(context),
            _rightPanel(context),
          ],
        ),
      ),
    );
  }

  Widget _leftPanel(context) {
    return Expanded(
      flex: 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            onPressed: () {},
            splashRadius: ICON_SIZE * 1.25,
            iconSize: ICON_SIZE * 1.25,
            icon: const Icon(Icons.image),
          ),
        ],
      ),
    );
  }

  Widget _centerPanel(context) {
    return Expanded(
      flex: 12,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _date(context),
          const SizedBox(height: SPACING),
          _image(context),
          const SizedBox(height: SPACING),
          _form(context),
        ],
      ),
    );
  }

  Widget _date(context) {
    return Text(
      'December 10, 2022',
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
    );
  }

  Widget _image(context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: SizedBox(
        height: size.height * 0.4,
        child: Image.asset(
          'assets/images/image.jpg',
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _form(context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _titleFormField(context),
          const SizedBox(height: SPACING),
          _scribeFormField(context),
        ],
      ),
    );
  }

  Widget _titleFormField(context) {
    return TextFormField(
      controller: _titleController,
      decoration: pageInputDecoration(
        context,
        'Title',
      ),
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a title.';
        }
        return null;
      },
    );
  }

  Widget _scribeFormField(context) {
    return TextFormField(
      controller: _scribingController,
      maxLines: null,
      // scrollPhysics: ,
      decoration: pageInputDecoration(
        context,
        'Start scribing...',
      ),
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some content.';
        }
        return null;
      },
    );
  }

  Widget _rightPanel(context) {
    return Expanded(
      flex: 4,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _discardButton(context),
              const SizedBox(width: SPACING),
              _doneButton(context)
            ],
          ),
        ],
      ),
    );
  }

  Widget _discardButton(context) {
    return TextButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(SPACING),
      ),
      child: Text(
        'Discard',
        style: Theme.of(context).textTheme.labelLarge!.copyWith(
              color: Theme.of(context).colorScheme.secondary,
            ),
      ),
    );
  }

  Widget _doneButton(context) {
    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : ElevatedButton(
            onPressed: addPage,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(SPACING),
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
            child: Text(
              'Done',
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
            ),
          );
  }
}
