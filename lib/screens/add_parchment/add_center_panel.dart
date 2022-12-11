import 'package:flutter/material.dart';
import 'package:grimoire/utils/utils.dart';

import '../../variables/constants.dart';
import '../../variables/global.dart';
import 'parchment_input_decoration.dart';

class AddCenterPanel extends StatefulWidget {
  const AddCenterPanel({
    super.key,
    required this.formKey,
    required this.titleController,
    required this.contentController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController titleController;
  final TextEditingController contentController;

  @override
  State<AddCenterPanel> createState() => _AddCenterPanelState();
}

class _AddCenterPanelState extends State<AddCenterPanel> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 13,
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
      formatDateFromDateTime(selectedDate),
      // selectedDate.toString(),
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
      key: widget.formKey,
      child: Column(
        children: [
          _titleFormField(context),
          const SizedBox(height: SPACING),
          _contentFormField(context),
        ],
      ),
    );
  }

  Widget _titleFormField(context) {
    return TextFormField(
      controller: widget.titleController,
      decoration: parchmentInputDecoration(
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

  Widget _contentFormField(context) {
    return TextFormField(
      controller: widget.contentController,
      maxLines: null,
      // scrollPhysics: ,
      decoration: parchmentInputDecoration(
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
}
