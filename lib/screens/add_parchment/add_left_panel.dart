import 'package:flutter/material.dart';

import '../../variables/constants.dart';

class AddLeftPanel extends StatelessWidget {
  const AddLeftPanel({super.key});

  @override
  Widget build(BuildContext context) {
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
}
