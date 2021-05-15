import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'global_state.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: Colors.green,
      ),
      body: Center(
          child: Column(
            children: <Widget>[
              Text(
                "Tilt Sensitivity",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w900),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Slider(
                    value: GlobalState.sensitivity,
                    min: 1,
                    max: 20,
                    divisions: 19,
                    label: GlobalState.sensitivity.round().toString(),
                    onChanged: (double value) {
                      setState(() {
                        GlobalState.sensitivity = value;
                      });
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.info),
                    onPressed: () {
                      GlobalState.infoText = descSensitivity;
                      Navigator.pushNamed(context, '/info');
                    },
                  ),
                ],
              ),
              Text(
                "Note Mode",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w900),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ToggleSwitch(
                    initialLabelIndex: GlobalState.noteMode,
                    labels: ['Legato', 'Chord'],
                    onToggle: (index) {
                      GlobalState.noteMode = index;
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.info),
                    onPressed: () {
                      GlobalState.infoText = descNoteMode;
                      Navigator.pushNamed(context, '/info');
                    },
                  ),
                ],
              ),
              Text(
                "Glissando Box",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w900),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ToggleSwitch(
                    initialLabelIndex: GlobalState.glissandoEnable,
                    labels: ['Off', 'On'],
                    onToggle: (index) {
                      GlobalState.glissandoEnable = index;
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.info),
                    onPressed: () {
                      GlobalState.infoText = descGlissandoEnable;
                      Navigator.pushNamed(context, '/info');
                    },
                  ),
                ],
              ),
              Text(
                "Glissando Restriction",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w900),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ToggleSwitch(
                    initialLabelIndex: GlobalState.glissandoRestrict,
                    labels: ['All', 'White', 'Black'],
                    onToggle: (index) {
                      GlobalState.glissandoRestrict = index;
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.info),
                    onPressed: () {
                      GlobalState.infoText = descGlissandoRestrict;
                      Navigator.pushNamed(context, '/info');
                    },
                  ),
                ],
              ),
              Text(
                "Onboard Sound",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w900),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ToggleSwitch(
                    initialLabelIndex: GlobalState.onboardSound,
                    labels: ['Off', 'On'],
                    onToggle: (index) {
                      GlobalState.onboardSound = index;
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.info),
                    onPressed: () {
                      GlobalState.infoText = descOnboardSound;
                      Navigator.pushNamed(context, '/info');
                    },
                  ),
                ],
              ),
              Text(
                "Interpolate Note Wheel",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w900),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ToggleSwitch(
                    initialLabelIndex: GlobalState.interpolateNoteWheel,
                    labels: ['Off', 'On'],
                    onToggle: (index) {
                      GlobalState.interpolateNoteWheel = index;
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.info),
                    onPressed: () {
                      GlobalState.infoText = descInterpolateNoteWheel;
                      Navigator.pushNamed(context, '/info');
                    },
                  ),
                ],
              ),
            ],
          )),
    );
  }
  //All of this stuff is for the info menu that explains each setting
  String descNoteMode = "This setting decides what happens when you tap a new note while already holding a note with your other thumb.\n\nLegato: Switches to the new note.\n\nChord: Both notes will play together.";
  String descSensitivity = "Lower sensitivity means you will need to tilt the device more to change notes.";
  String descGlissandoEnable = "If enabled, the top section of the tap box will be devoted to glissandos. Notes held in the glissando box will change when you tilt the device, as opposed to being held.";
  String descGlissandoRestrict = "Decides what notes glissandos will be restricted to.\n\nAll: Will play any note.\n\nWhite: Only plays white notes.\n\nBlack: Only plays black notes.";
  String descOnboardSound = "If enabled, uses simple onboard sound samples instead of a MIDI connection.";
  String descInterpolateNoteWheel = "If enabled, the Note Wheel will more smoothly transition between notes. However, this will double the latency time on the gyro.";

}