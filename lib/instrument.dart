import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobile_midi/global_state.dart';
import 'package:sensors/sensors.dart';
import 'dart:async';
import 'notes.dart';

class InstrumentPage extends StatefulWidget {
  @override
  _InstrumentPageState createState() => _InstrumentPageState();
}
class _InstrumentPageState extends State<InstrumentPage> {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Mobile MIDI"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                child: Text('Settings'),
                onPressed: () {
                  Navigator.pushNamed(context, '/settings');
                },
              ),
              DrumPadWidget(),
              NoteWheelWidget(),
            ],
          ),
        ));
  }
  void dispose() {
    super.dispose();
  }
}

class DrumPadWidget extends StatefulWidget {
  @override
  _DrumPadWidgetState createState() => _DrumPadWidgetState();
}

class _DrumPadWidgetState extends State<DrumPadWidget> {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  StreamSubscription<String> _setupSubscription;
  //MidiCommand _midiCommand = MidiCommand();



  /*@override
  void initState() {
    super.initState();

    _midiCommand.startScanningForBluetoothDevices().catchError((err) {
      print("Error $err");
    });
    _setupSubscription = _midiCommand.onMidiSetupChanged.listen((data) {
      print("setup changed $data");

      switch (data) {
        case "deviceFound":
          setState(() {});
          break;
      // case "deviceOpened":
      //   break;
        default:
        // print("Unhandled setup change: $data");
          break;
      }
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Listener(
          onPointerDown: (details) {
            Notes.noteOn(80);
          },
          onPointerUp: (details) {
            Notes.noteOff(48);
          },
          child: Container(
            decoration: BoxDecoration(color: Colors.orange, border: Border.all()),
            padding: EdgeInsets.all(16.0),
            child: Text('DRUM'),
          ),
        ),
      ],
    );
  }
  @override
  void dispose() {
    //_setupSubscription.cancel();
    super.dispose();
  }
}

class NoteWheelWidget extends StatefulWidget {
  @override
  _NoteWheelWidgetState createState() => _NoteWheelWidgetState();
}

class _NoteWheelWidgetState extends State<NoteWheelWidget> {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  double accel_x = 0;
  double accel_y = 0;
  double accel_z = 0;
  double gyro_x = 0;
  double gyro_y = 0;
  double gyro_z = 0;
  double noteWidth = 70;
  double globalPos = 0;
  DateTime prev = DateTime.now();
  ScrollController noteWheelCon = ScrollController();
  TextEditingController textEd = TextEditingController();
  //Stream<dynamic> accel;
  List<int> notes = <int>[];
  List<String> notesText = <String>[];
  List<bool> notesColor = <bool>[];
  int counter = 0;
  int countmax = 60;

  String noteText(int n) {
    String builtNote = "";
    int note = n % 12;
    int octave = (n~/12)-1;
    if (note == 0) {builtNote = "c";}
    if (note == 1) {builtNote = "c#";}
    if (note == 2) {builtNote = "d";}
    if (note == 3) {builtNote = "d#";}
    if (note == 4) {builtNote = "e";}
    if (note == 5) {builtNote = "f";}
    if (note == 6) {builtNote = "f#";}
    if (note == 7) {builtNote = "g";}
    if (note == 8) {builtNote = "g#";}
    if (note == 9) {builtNote = "a";}
    if (note == 10) {builtNote = "a#";}
    if (note == 11) {builtNote = "b";}
    builtNote += " ";
    builtNote += octave.toString();
    return builtNote;
  }

  bool noteColor(int n) {
    int note = n % 12;
    if (note == 1 || note == 3 || note == 6 || note == 8 || note == 10) {
      return true;
    }
    return false;
  }

  void addDummyNotes() {
    for (int i = 0; i < 25; i++) {
      notes.add(127);
      notesText.add("");
      notesColor.add(false);
    }
  }

  void buildNotesChromatic() {
    for (int i = 0; i < 128; i++) {
      notes.add(i);
      notesText.add(noteText(i));
      notesColor.add(noteColor(i));
    }
    addDummyNotes();
  }

  @override
  void initState() {
    //Build Notes

    super.initState();
    accelerometerEvents.listen((AccelerometerEvent event) {
      if (mounted) {
        accel_x = event.x;
        accel_y = event.y;
        accel_z = event.z;
      }
    });
    gyroscopeEvents.listen((GyroscopeEvent event) {
      if (mounted) {
          gyro_x = event.x;
          gyro_y = event.y;
          gyro_z = event.z;

          //Determine the notewheel's correct position
          globalPos += gyro_z * noteWidth * GlobalState.sensitivity;
          if (globalPos > noteWidth * notes.length) {
            globalPos = noteWidth * notes.length;
          }
          if (globalPos < 0) {
            globalPos = 0;
          }

          /*counter += 1;
          if (counter >= countmax) {
            counter = 0;
            DateTime now = DateTime.now();
            print(now.difference(prev));
          }*/

          //Handle the animation
          //textEd.text = globalPos.toString();
          noteWheelCon.jumpTo(globalPos);
          /*DateTime now = DateTime.now();
          noteWheelCon.animateTo(
              globalPos,
              curve: Curves.linear,
              duration: now.difference(prev),
          );
          prev = now;*/
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    buildNotesChromatic();
    return Column(
      children: <Widget>[
        Container(
          height:40,
          child: ListView.builder (
            controller: noteWheelCon,
            scrollDirection: Axis.horizontal,
            physics: NeverScrollableScrollPhysics(),
            itemCount: notes.length,
            itemBuilder: (BuildContext context, int index) {
              return new Container(
                width: noteWidth,
                color: notesColor[index] ? Colors.grey : Colors.white,
                child: Text(notesText[index])
              );
            }
          )
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Listener(
              onPointerDown: (details) {
                Notes.noteOn(globalPos~/noteWidth);
              },
              onPointerUp: (details) {
                Notes.noteOff(48);
              },
              child: Container(
                decoration: BoxDecoration(color: Colors.orange, border: Border.all()),
                padding: EdgeInsets.all(16.0),
                child: Text('DRUM'),
              ),
            ),
          ],
        ),
      ],
    );
  }
  void dispose() {
    super.dispose();
  }
}