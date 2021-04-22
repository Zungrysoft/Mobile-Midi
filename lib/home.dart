import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Menu'),
        backgroundColor: Colors.green,
      ),
      body: Center(
          child: Column(
            children: <Widget>[
              RaisedButton(
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