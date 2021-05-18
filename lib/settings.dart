import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'global_state.dart';
import 'notes.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  void dispose() {
    super.dispose();
    GlobalState.save();
  }
  void initState() {
    super.initState();
    GlobalState.load();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: new SingleChildScrollView(
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
                    fontSize: 10,
                    labels: ['Legato', 'Chord', 'Auto-Chord'],
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
                "Auto-Chord Selection",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w900),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ToggleSwitch(
                    initialLabelIndex: GlobalState.autoChord,
                    labels: ['Maj','Min','Pow','Oct'],
                    onToggle: (index) {
                      GlobalState.autoChord = index;
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.info),
                    onPressed: () {
                      GlobalState.infoText = descAutoChord;
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
              Text(
                "Enable Vibration",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w900),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ToggleSwitch(
                    initialLabelIndex: GlobalState.vibrationEnable,
                    labels: ['Off', 'On'],
                    onToggle: (index) {
                      GlobalState.vibrationEnable = index;
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.info),
                    onPressed: () {
                      GlobalState.infoText = descVibrationEnable;
                      Navigator.pushNamed(context, '/info');
                    },
                  ),
                ],
              ),
              Text(
                "Controls Mode",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w900),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ToggleSwitch(
                    initialLabelIndex: GlobalState.controlsMode,
                    labels: ['1', '2', '3'],
                    onToggle: (index) {
                      GlobalState.controlsMode = index;
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.info),
                    onPressed: () {
                      GlobalState.infoText = descControlsMode;
                      Navigator.pushNamed(context, '/info');
                    },
                  ),
                ],
              ),
              Text(
                "MIDI Settings",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w900),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    child: Text('MIDI Settings'),
                    onPressed: () {
                      Navigator.pushNamed(context, '/midi_settings');
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  //All of this stuff is for the info menu that explains each setting
  String descSensitivity = "Lower sensitivity means you will need to tilt the device more to change notes.";
  String descNoteMode = "This setting decides what happens when you tap a new note while already holding a note with your other thumb.\n\nLegato: Switches to the new note.\n\nChord: Both notes will play together.\n\nAuto-Chord: Like Legato, but it plays the selected chord instead.";
  String descAutoChord = "If you have Auto-Chord selected, this setting determines which chord is played.";
  String descOnboardSound = "If enabled, the app will use simple onboard sound samples instead of a MIDI connection.";
  String descInterpolateNoteWheel = "If enabled, the Note Wheel will more smoothly transition between notes. However, this will effectively double the latency time on the gyro.";
  String descVibrationEnable = "If enabled, the device will vibrate whenever your selected note changes.";
  String descControlsMode = "Determines what controls will be available on the instrument screen.\n\nMode 1: Various MIDI CC controls.\n\nMode 2: Drum Pads\n\nMode 3: Settings";

}