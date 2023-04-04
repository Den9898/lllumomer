import 'package:flutter/material.dart';

import '../bottom_bar/bottom_bar.dart';
import '../servis/inform_to_screens.dart';

class Save extends StatelessWidget {
  final InformToscreens informToscreens;

  const Save(this.informToscreens, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Text('Sace'),
      ),
      bottomNavigationBar: BottomBar(informToscreens),
    );
  }
}
