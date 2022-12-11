import 'package:flutter/material.dart';

import '../variables/global.dart';
import 'home_screen/home_left_panel.dart';
import 'home_screen/main_app_bar.dart';
import 'home_screen/home_right_panel.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print('HOME SCREEN: ${selectedDate.toString()}');
    // DateTime selectedDate = DateTime.now();
    return Scaffold(
      appBar: const MainAppBar(),
      body: Row(
        children: [
          HomeLeftPanel(),
          const HomeRightPanel(),
        ],
      ),
    );
  }
}
