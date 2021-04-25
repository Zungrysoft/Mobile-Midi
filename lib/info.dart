import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'global_state.dart';

class InfoPage extends StatefulWidget {
  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Info'),
        backgroundColor: Colors.green,
      ),
      body: Center(
          child: Column(
            children: <Widget>[
              Text(
                '' + GlobalState.infoText,
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w900),
              ),
            ],
          )),
    );
  }
}