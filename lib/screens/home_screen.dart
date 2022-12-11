import 'package:flutter/material.dart';

import 'home_screen/home_left_panel.dart';
import 'home_screen/main_app_bar.dart';
import 'home_screen/home_right_panel.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(),
      body: Row(
        children: const [
          HomeLeftPanel(),
          HomeRightPanel(),
        ],
      ),
    );
  }
}
