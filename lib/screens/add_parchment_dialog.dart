import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/grimoire.dart';
import '../providers/scribe.dart';
import '../variables/constants.dart';
import '../providers/parchment.dart';
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

  Future<void> addParchment(context) async {
    // MOVE THIS INTO GRIMOIRE METHOD
    try {
      setState(() {
        _isLoading = true;
      });

      await Future.delayed(const Duration(seconds: 1));

      final isValid = _formKey.currentState!.validate();
      if (!isValid) {
        throw Exception('Form not validated');
      }

      final currScribeId = FirebaseAuth.instance.currentUser!.uid;
      final currScribeData = await FirebaseFirestore.instance
          .collection('scribes')
          .where('uid', isEqualTo: currScribeId)
          .get();
      final String author = currScribeData.docs[0].get('display_name');

      await FirebaseFirestore.instance.collection('parchments').add(
            Parchment(
              scribeId: Provider.of<Scribe>(context, listen: false).uid,
              author: author,
              created: Timestamp.fromDate(
                  Provider.of<Grimoire>(context, listen: false).selectedDate!),
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
              addParchmentFunction: () => addParchment(context),
              isLoading: _isLoading,
            ),
          ],
        ),
      ),
    );
  }
}
