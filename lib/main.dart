import 'dart:async';

import 'package:flutter/material.dart';
import 'package:torch_compat/torch_compat.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "섬광탄",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FlashScreen(),
    );
  }
}

class FlashScreen extends StatefulWidget {
  @override
  _FlashScreenState createState() => _FlashScreenState();
}

class _FlashScreenState extends State<FlashScreen> {
  bool _flashOn;
  bool _sec;

  void flareBomb(int selectedInt) {
    Timer.periodic(Duration(milliseconds: selectedInt), (timer) {
      _sec = !_sec;

      _sec && _flashOn ? TorchCompat.turnOn() : TorchCompat.turnOff();
      _flashOn ? timer.isActive : timer.cancel();
    });
  }

  Widget button(BuildContext context, int selectedInt) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;
    return Container(
      width: width * 0.25,
      height: width * 0.25,
      child: RaisedButton(
        onPressed: () {
          flareBomb(selectedInt);
          setState(() {
            _flashOn = true;
          });
        },
        child: Text('$selectedInt 초'),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _flashOn = false;
    _sec = false;
  }

  @override
  void dispose() {
    TorchCompat.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: _flashOn
            ? Center(
                child: Container(
                  width: width * 0.3,
                  height: width * 0.3,
                  child: RaisedButton(
                    onPressed: () {
                      TorchCompat.turnOff();
                      setState(() {
                        _flashOn = false;
                      });
                    },
                  ),
                ),
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: height * 0.1),
                      child: Text(
                        "섬광탄",
                        style: TextStyle(
                            color: Colors.white, fontSize: width * 0.128),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          width: width * 0.25,
                          height: width * 0.25,
                          child: RaisedButton(
                            onPressed: () {
                              TorchCompat.turnOn();
                              setState(() {
                                _flashOn = true;
                              });
                              _flashOn = true;
                            },
                            child: Container(),
                          ),
                        ),
                        button(context, 500),
                        button(context, 300)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        button(context, 200),
                        button(context, 100),
                        button(context, 50)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        button(context, 30),
                        button(context, 20),
                        button(context, 10)
                      ],
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
