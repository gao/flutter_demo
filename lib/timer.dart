import 'package:flutter/material.dart';
import 'dart:async';

class TimerPage extends StatefulWidget {
  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  bool isActive = false;
  int secondsPassed = 0;

  Timer timer;

  handleTick() {
    if (isActive) {
      setState(() {
        secondsPassed = secondsPassed + 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (timer == null) {
      timer = Timer.periodic(
        Duration(
          seconds: 1,
        ),
            (Timer timer) {
          handleTick();
        },
      );
    }
    int seconds = secondsPassed % 60;
    int minutes = secondsPassed ~/ 60;
    int hours = secondsPassed ~/ (60 * 60);

    return Scaffold(
      appBar: AppBar(
        title: Text('Timer'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CustomTextContainer('HRS', hours.toString().padLeft(2, '0')),
                CustomTextContainer('MIN', minutes.toString().padLeft(2, '0')),
                CustomTextContainer('SEC', seconds.toString().padLeft(2, '0')),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0),
              child: RaisedButton(
                child: Text(isActive ? 'STOP' : 'START'),
                onPressed: () {
                  setState(() {
                    isActive = !isActive;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTextContainer extends StatelessWidget {
  CustomTextContainer(this.label, this.value);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.black87,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            '$value',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 54.0),
          ),
          Text(
            '$label',
            style: TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
