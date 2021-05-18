import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'global_state.dart';
import 'notes.dart';

class MidiSettingsPage extends StatefulWidget {
  @override
  _MidiSettingsPageState createState() => _MidiSettingsPageState();
}

class _MidiSettingsPageState extends State<MidiSettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MIDI Settings'),
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
                "CC1 Control",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w900),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Slider(
                    value: GlobalState.CC1Set.toDouble(),
                    min: 1,
                    max: 127,
                    divisions: 125,
                    label: GlobalState.CC1Set.round().toString(),
                    onChanged: (double value) {
                      setState(() {
                        GlobalState.CC1Set = value.toInt();
                      });
                    },
                  ),
                ],
              ),
              Text(
                "CC2 Control",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w900),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Slider(
                    value: GlobalState.CC2Set.toDouble(),
                    min: 1,
                    max: 127,
                    divisions: 125,
                    label: GlobalState.CC2Set.round().toString(),
                    onChanged: (double value) {
                      setState(() {
                        GlobalState.CC2Set = value.toInt();
                      });
                    },
                  ),
                ],
              ),
              Text(
                "CC3 Control",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w900),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Slider(
                    value: GlobalState.CC3Set.toDouble(),
                    min: 1,
                    max: 127,
                    divisions: 125,
                    label: GlobalState.CC3Set.round().toString(),
                    onChanged: (double value) {
                      setState(() {
                        GlobalState.CC3Set = value.toInt();
                      });
                    },
                  ),
                ],
              ),
              Text(
                "CC4 Control",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w900),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Slider(
                    value: GlobalState.CC4Set.toDouble(),
                    min: 1,
                    max: 127,
                    divisions: 125,
                    label: GlobalState.CC4Set.round().toString(),
                    onChanged: (double value) {
                      setState(() {
                        GlobalState.CC4Set = value.toInt();
                      });
                    },
                  ),
                ],
              ),
              Text(
                "CC5 Control",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w900),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Slider(
                    value: GlobalState.CC5Set.toDouble(),
                    min: 1,
                    max: 127,
                    divisions: 125,
                    label: GlobalState.CC5Set.round().toString(),
                    onChanged: (double value) {
                      setState(() {
                        GlobalState.CC5Set = value.toInt();
                      });
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
  String descMidiChannel = "Determines which channel the MIDI messages will be sent over for the note selector. Your synthesizer will need to be configured to receive MIDI messages on this channel.";
  String descDrumPadChannel = "Determines which channel the MIDI messages will be sent over for the drum pads. Your synthesizer will need to be configured to receive MIDI messages on this channel.";
  String descNoteVelocity = "Determines what velocity the notes will be sent at. Higher velocity simulates hitting the keys harder on a piano.";

}