import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'global_state.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Timer timer;

  @override
  Widget build(BuildContext context) {
    GlobalState.load();
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Menu'),
        backgroundColor: Colors.green,
      ),
      body: Center(
          child: Column(
            children: <Widget>[
              ElevatedButton(
                child: Text('Play Instrument'),
                onPressed: () {
                  Navigator.pushNamed(context, '/instrument');
                },
              ),
            ],
          )),
    );
  }
}