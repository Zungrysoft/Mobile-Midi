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
                    icon: const Icon(Icons.refresh),
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
            ],
          ),
        ),
      ),
    );
  }
  //All of this stuff is for the info menu that explains each setting
  String descSensitivity = "Lower sensitivity means you will need to tilt the device more to change notes.";
  String descNoteMode = "This setting decides what happens when you tap a new note while already holding a note with your other thumb.\n\nLegato: Switches to the new note.\n\nChord: Both notes will play together.\n\nAuto-Chord: Like Legato, but it play the selected chord instead.";
  String descAutoChord = "If you have Auto-Chord selected, this setting determines which chord is played.";
  String descGlissandoRestrict = "Decides what notes glissandos will be restricted to.\n\nAll: Will play any note.\n\nWhite: Only plays white notes.\n\nBlack: Only plays black notes.";
  String descOnboardSound = "If enabled, the app will use simple onboard sound samples instead of a MIDI connection.";
  String descInterpolateNoteWheel = "If enabled, the Note Wheel will more smoothly transition between notes. However, this will effectively double the latency time on the gyro.";
  String descVibrationEnable = "If enabled, the device will vibrate whenever your selected note changes.";
  String descMidiChannel = "Determines which channel the MIDI messages will be sent over. Your synthesizer will need to be configured to receive MIDI messages on this channel.";
  String descNoteVelocity = "Determines what velocity the notes will be sent at. Higher velocity simulates hitting the keys harder on a piano.";

}