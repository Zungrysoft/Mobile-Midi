import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'home.dart';
import 'instrument.dart';
import 'settings.dart';
import 'midi_settings.dart';
import 'info.dart';
import 'global_state.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mobile MIDI',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: <String, WidgetBuilder> {
        '/': (context) => HomePage(),
        '/instrument': (context) => InstrumentPage(),
        '/settings': (context) => SettingsPage(),
        '/midi_settings': (context) => MidiSettingsPage(),
        '/info': (context) => InfoPage(),
      },
    );
  }
}
