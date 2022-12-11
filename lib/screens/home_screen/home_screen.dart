import 'package:flutter/material.dart';

import '../add_page/add_page_dialog.dart';
import 'left_panel.dart';
import 'main_app_bar.dart';
import 'right_panel.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(),
      body: Row(
        children: const [
          LeftPanel(),
          RightPanel(),
        ],
      ),
      floatingActionButton: _fab(context),
    );
  }

  Widget _fab(context) {
    return FloatingActionButton(
      onPressed: () {
        showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) {
            return const AddPageDialog();
          },
        );
      },
      backgroundColor: Theme.of(context).colorScheme.primary,
      tooltip: 'New Page',
      child: Icon(
        Icons.bookmark_add_outlined,
        color: Theme.of(context).colorScheme.onPrimary,
      ),
    );
  }
}
