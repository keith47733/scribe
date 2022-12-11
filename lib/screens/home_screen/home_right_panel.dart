import 'package:flutter/material.dart';

import '../../variables/constants.dart';
import 'build_grimoire.dart';

class HomeRightPanel extends StatelessWidget {
  const HomeRightPanel({super.key});

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
            BuildGrimoire(),
          ],
        ),
      ),
    );
  }
}
