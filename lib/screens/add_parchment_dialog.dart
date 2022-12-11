import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../models/parchment.dart';
import 'add_parchment/add_center_panel.dart';
import 'add_parchment/add_left_panel.dart';
import 'add_parchment/add_right_panel.dart';

class AddParchmentDialog extends StatefulWidget {
  const AddParchmentDialog({super.key});

  @override
  State<AddParchmentDialog> createState() => _AddParchmentDialogState();
}

class _AddParchmentDialogState extends State<AddParchmentDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  bool _isLoading = false;

  Future<void> addParchment() async {
    try {
      setState(() {
        _isLoading = true;
      });

      await Future.delayed(const Duration(seconds: 1));

      final isValid = _formKey.currentState!.validate();
      if (!isValid) {
        throw Exception('Form not validated');
      }

      await FirebaseFirestore.instance.collection('parchments').add(
            Parchment(
              parchment: '',
              scribeId: FirebaseAuth.instance.currentUser!.uid,
              author: 'Keith',
              created: Timestamp.fromDate(DateTime.now()),
              photoUrls: 'photo url',
              title: _titleController.text.trim(),
              content: _contentController.text.trim(),
            ).toMap(),
          );
    } catch (error) {
      print('SAVE PARCHMENT ERROR: ${error.toString()}');
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
            const AddLeftPanel(),
            AddCenterPanel(
              formKey: _formKey,
              titleController: _titleController,
              contentController: _contentController,
            ),
            AddRightPanel(
              addParchmentFunction: addParchment,
              isLoading: _isLoading,
            ),
          ],
        ),
      ),
    );
  }
}
