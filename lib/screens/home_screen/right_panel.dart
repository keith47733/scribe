import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import 'pages.dart';

class RightPanel extends StatelessWidget {
  const RightPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Padding(
        padding: const EdgeInsets.only(
          top: SPACING,
          bottom: SPACING / 2,
          left: SPACING,
          right: SPACING,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: const [
            Pages(),
          ],
        ),
      ),
    );
  }
}
