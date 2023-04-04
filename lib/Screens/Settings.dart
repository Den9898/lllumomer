import 'package:flutter/material.dart';

import '../bottom_bar/bottom_bar.dart';
import '../servis/inform_to_screens.dart';

class Settings extends StatelessWidget {
  final InformToscreens informToscreens;

  const Settings(this.informToscreens, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
            child: Text(
          'Setting',
          style: TextStyle(fontWeight: FontWeight.bold),
        )),
      ),
      bottomNavigationBar: BottomBar(informToscreens),
    );
  }
}
