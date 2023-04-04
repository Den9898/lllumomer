import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lllumomer/main.dart';
import 'package:noise_meter/noise_meter.dart';

import '../bottom_bar/bottom_bar.dart';
import '../servis/inform_to_screens.dart';

class MyApp extends StatefulWidget {
  final InformToscreens informToscreens;
  const MyApp(this.informToscreens,{ Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  double A = 0.0;
  bool isRecording = false;
  StreamSubscription<NoiseReading>? noiseSubscription;
  late NoiseMeter noiseMeter;
  List<double>Noice = [0];

  @override
  void initState() {
    super.initState();
    noiseMeter = new NoiseMeter(onError);
  }

  @override
  void dispose() {
    noiseSubscription?.cancel();
    super.dispose();
  }

  void onData(NoiseReading noiseReading) {
    setState(() {
      if (!isRecording) {
        isRecording = true;
      }
    });
    print(noiseReading.toString());
    A = noiseReading.maxDecibel;
    Noice.add(A);
   if( Noice.contains(0)){
     Noice.removeAt(0);
    }
   
  }

  void onError(Object error) {
    print(error.toString());
    isRecording = false;
  }

  void start() async {
    try {
      noiseSubscription = noiseMeter.noiseStream.listen(onData);
      isRecording = true;

    } catch (err) {
      print(err);
    }
  }

  void stop() async {
    try {
      if (noiseSubscription != null) {
        noiseSubscription!.cancel();
        noiseSubscription = null;
      }
      setState(() {
        isRecording = false;
      });
    } catch (err) {
      print('stopRecorder error: $err');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: () {

                      widget.informToscreens.goToRoute(AllRoutes.info);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Image.asset(
                        'Assets/icon.png',
                        width: 30,
                        height: 30,
                      ),
                    ),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: () {

                      widget.informToscreens.goToRoute(AllRoutes.Settings);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Image.asset(
                        'Assets/setting.jpg',
                        height: 30,
                        width: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 200,
                    color: Colors.blue,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        A.toStringAsFixed(1),
                        style: TextStyle(
                            fontSize: 80, fontWeight: FontWeight.bold),
                      ),
                      Container(
                        height: 50,
                        width: 4,
                        color: Colors.black,
                      ),
                      Column(
                        children:  [
                          Text(
                            'Min ${Noice.reduce(min).toStringAsFixed(1)}',
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                          Text(
                            'Max ${Noice.reduce(max).toStringAsFixed(1)}',
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.red),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(),
          ],
        ),
      ),
      bottomNavigationBar: BottomBar(widget.informToscreens),
    );
  }
}
