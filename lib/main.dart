import 'package:flutter/material.dart';
import 'package:lllumomer/servis/inform_to_screens.dart';
import 'Screens/Home.dart';
import 'Screens/Info.dart';
import 'Screens/Save.dart';
import 'Screens/Settings.dart';

class AllRoutes {
  static const String MyApp = '/';
  static const String info = '/info';
  static const String Save = '/Save';
  static const String Settings = '/Settings';
}

void main() {
  runApp(
    const NoiceMetr(),
  );
}

class NoiceMetr extends StatefulWidget {
  const NoiceMetr({Key? key}) : super(key: key);

  @override
  State<NoiceMetr> createState() => _NoiceMetrState();
}

class _NoiceMetrState extends State<NoiceMetr> {
  String thisRoute = AllRoutes.MyApp;
  bool is404 = false;
  late InformToscreens informToscreens;





  void goToRoute(String route) {
    setState(() {
      thisRoute = route;
    });
  }
  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    informToscreens = InformToscreens(thisRoute , goToRoute );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Schyler'),
      home: Navigator(
        pages: [
          MaterialPage(
            child: MyApp(informToscreens),
          ),
          if (thisRoute == AllRoutes.Save)
            MaterialPage(
              child: Save(informToscreens),
            ),
          if (thisRoute == AllRoutes.Settings)
            MaterialPage(
              child: Settings(informToscreens),
            ),
          if (thisRoute == AllRoutes.info)
            MaterialPage(
              child: info(informToscreens),
            ),
          if (is404 == true)
            MaterialPage(
              child: Scaffold(
                body: Center(
                  child: Text('перезапустите'),
                ),
              ),
            )
        ],
        onPopPage: (route, result) {
          if (!route.didPop(result)) {
            return false;
          }
          return true;
        },
      ),
    );
  }
}
