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
                "Refresh MIDI Connection",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w900),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    icon: const Icon(CupertinoIcons.refresh_circled),
                    onPressed: () {
                      Notes.usbInit();
                    },
                  ),
                ],
              ),
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
                "MIDI Channel",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w900),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Slider(
                    value: (GlobalState.midiChannel).toDouble()+1,
                    min: 1,
                    max: 16,
                    divisions: 15,
                    label: (GlobalState.midiChannel.round()+1).toString(),
                    onChanged: (double value) {
                      setState(() {
                        GlobalState.midiChannel = value.toInt()-1;
                      });
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.info),
                    onPressed: () {
                      GlobalState.infoText = descMidiChannel;
                      Navigator.pushNamed(context, '/info');
                    },
                  ),
                ],
              ),
              Text(
                "Drum Pad MIDI Channel",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w900),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Slider(
                    value: (GlobalState.drumPadChannel).toDouble()+1,
                    min: 1,
                    max: 16,
                    divisions: 15,
                    label: (GlobalState.drumPadChannel.round()+1).toString(),
                    onChanged: (double value) {
                      setState(() {
                        GlobalState.drumPadChannel = value.toInt()-1;
                      });
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.info),
                    onPressed: () {
                      GlobalState.infoText = descDrumPadChannel;
                      Navigator.pushNamed(context, '/info');
                    },
                  ),
                ],
              ),
              Text(
                "MIDI Note Velocity",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w900),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Slider(
                    value: GlobalState.noteVelocity.toDouble(),
                    min: 1,
                    max: 127,
                    divisions: 125,
                    label: GlobalState.noteVelocity.round().toString(),
                    onChanged: (double value) {
                      setState(() {
                        GlobalState.noteVelocity = value.toInt();
                      });
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.info),
                    onPressed: () {
                      GlobalState.infoText = descNoteVelocity;
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
  String descMidiChannel = "Determines which channel the MIDI messages will be sent over for the note selector. Your synthesizer will need to be configured to receive MIDI messages on this channel.";
  String descDrumPadChannel = "Determines which channel the MIDI messages will be sent over for the drum pads. Your synthesizer will need to be configured to receive MIDI messages on this channel.";
  String descNoteVelocity = "Determines what velocity the notes will be sent at. Higher velocity simulates hitting the keys harder on a piano.";
  String descControlsMode = "Determines what controls will be available on the instrument screen.\n\nMode 1: Various MIDI CC controls.\n\nMode 2: Drum Pads\n\nMode 3: Settings";

}