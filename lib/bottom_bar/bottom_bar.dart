import 'package:flutter/material.dart';
import 'package:lllumomer/Screens/Home.dart';
import 'package:lllumomer/main.dart';
import 'package:permission_handler/permission_handler.dart';

import '../servis/inform_to_screens.dart';

class BottomBar extends StatefulWidget {
  final InformToscreens informToscreens;
  const BottomBar(this.informToscreens,{ Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  thisRoute() => ModalRoute.of(context)?.settings.name;

  activeButtonColor(String route) {
    if (route == thisRoute()) {
      return Color.fromARGB(255, 230, 230, 230);
    } else {
      return Colors.transparent;
    }
  }



  getIsRecording() {
    setState(() {});
    return context.findAncestorStateOfType<MyAppState>()?.isRecording ?? false;
  }

  getOnStart() => context.findAncestorStateOfType<MyAppState>()?.start();

  getOnStop() => context.findAncestorStateOfType<MyAppState>()?.stop();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Material(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(18),
            ),
            child: InkWell(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(18),
              ),
              onTap: () {
                Navigator.of(context).pushNamed('/');
              },
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 4,
                height: 75,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Image.asset(
                    'Assets/qwe.png',
                    height: 30,
                    width: 30,
                  ),
                ),
              ),
            ),
          ),
          Material(
            // Микрофон
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(18),
            ),
            color: activeButtonColor(AllRoutes.MyApp),
            child: InkWell(
              onTap: () async {
                widget.informToscreens.goToRoute(AllRoutes.MyApp);

                if (widget.informToscreens == AllRoutes.MyApp &&
                    await Permission.microphone.status.isDenied) {
                  await Permission.microphone.request();
                } else {
                  print(await Permission.microphone.status);
                }
                if (getIsRecording() == false) {
                  getOnStart();
                } else if (getIsRecording() == true) {
                  getOnStop();
                }
              },
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 4,
                height: 75,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: getIsRecording()
                      ? Icon(Icons.pause_presentation_rounded)
                      : Image.asset(
                          'Assets/qw.png',
                          height: 30,
                          width: 30,
                        ),
                ),
              ),
            ),
          ),
          Material(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(18),
            ),
            color: activeButtonColor(AllRoutes.Save),
            child: InkWell(
              onTap: () {
                widget.informToscreens.goToRoute(AllRoutes.Save);
              },
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 4,
                height: 75,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Image.asset(
                    'Assets/info2.png',
                    height: 30,
                    width: 30,
                  ),
                ),
              ),
            ),
          ),
          Material(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(18),
            ),
            child: InkWell(
              onTap: () {},
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 4,
                height: 75,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Image.asset(
                    'Assets/timer.png',
                    height: 30,
                    width: 30,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
