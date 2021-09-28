import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String light = 'green';
  String instruction = 'GO';
  Color? instructionColor = Colors.green[500];
  String buttonStatus = "Start";

  int counter = 30;
  Timer? timer;

  void startTimer() {
    if (buttonStatus == 'Start') {
      buttonStatus = 'Stop';
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          if (counter > 0) {
            counter--;
          } else {
            if (light == 'green') {
              light = 'yellow';
              instruction = 'SLOW';
              instructionColor = Colors.yellow[500];
              counter = 3;
            } else if (light == 'yellow') {
              light = 'red';
              instruction = 'STOP!';
              instructionColor = Colors.red[500];
              counter = 15;
            } else {
              light = 'green';
              instruction = 'GO';
              instructionColor = Colors.green[500];
              counter = 30;
            }
          }
        });
      });
    } else {
      buttonStatus = 'Start';
      timer?.cancel();
    }
  }

  @override
  void initState() {
    light = 'green';
    instruction = 'GO';
    instructionColor = Colors.green[500];
    super.initState();
  }

  int turnOnLight(String lightactive) {
    int num = 100;
    if (light == lightactive) {
      num = 500;
    }
    return num;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Material App'),
          backgroundColor: Colors.teal[300],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                instruction,
                style: TextStyle(
                  fontSize: 40,
                  color: instructionColor,
                ),
              ),
              Text(
                counter.toString(),
                style: TextStyle(
                  fontSize: 32,
                  color: instructionColor,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    Icons.circle,
                    size: 100,
                    color: Colors.green[turnOnLight('green')],
                  ),
                  Icon(
                    Icons.circle,
                    size: 100,
                    color: Colors.yellow[turnOnLight('yellow')],
                  ),
                  Icon(
                    Icons.circle,
                    size: 100,
                    color: Colors.red[turnOnLight('red')],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.directions_walk,
                    size: 100,
                    color: Colors.red[turnOnLight('red')],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.directions_walk,
                    size: 100,
                    color: Colors.green[turnOnLight('green')],
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: startTimer,
                child: Text(buttonStatus),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
