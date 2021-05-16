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
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              ElevatedButton(
                child: Text('Settings'),
                onPressed: () {
                  Navigator.pushNamed(context, '/settings');
                },
              ),
              DrumPadWidget(),
              Align(
                alignment: Alignment.bottomCenter,
                child:NoteWheelWidget(),
              ),
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
            Notes.noteOff(80);
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
  List<int> heldNotes = [];
  bool steady = false;
  bool glissando = false;
  int fingers = 0;
  int prevNote = 0;

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
          if (!steady) {
            globalPos += gyro_z * noteWidth * GlobalState.sensitivity;
            if (globalPos > noteWidth * notes.length) {
              globalPos = noteWidth * notes.length;
            }
            if (globalPos < 0) {
              globalPos = 0;
            }
          }

          //Glissando
          int curNote = selNote();
          if (curNote != prevNote && glissando) {
            noteGlissando(curNote);
          }
          prevNote = curNote;

          //Handle the animation
          if (GlobalState.interpolateNoteWheel == 1) {
            DateTime now = DateTime.now();
            noteWheelCon.animateTo(
              globalPos,
              curve: Curves.linear,
              duration: now.difference(prev),
            );
            prev = now;
          } else {
            noteWheelCon.jumpTo(globalPos);
          }
      }
    });
  }

  int selNote() {
    return globalPos~/noteWidth;
  }

  void notePressed(int n) {
    fingers ++;
    print("PRESSED");
    //Legato Mode
    if (GlobalState.noteMode == 0 || GlobalState.noteMode == 2) {
      //Turn off all previous notes
      for (int i = 0; i < heldNotes.length; i ++) {
        int stop = heldNotes[i];
        Notes.noteOff(stop);
      }
      heldNotes.clear();

      //Turn on the new note
      Notes.noteOn(n);
      heldNotes.add(n);
      if (GlobalState.noteMode == 2) {
        if (GlobalState.autoChord == 0) {
          Notes.noteOn(n+4);
          heldNotes.add(n+4);
          Notes.noteOn(n+7);
          heldNotes.add(n+7);
        }
        else if (GlobalState.autoChord == 1) {
          Notes.noteOn(n+3);
          heldNotes.add(n+3);
          Notes.noteOn(n+7);
          heldNotes.add(n+7);
        }
        else if (GlobalState.autoChord == 2) {
          Notes.noteOn(n+7);
          heldNotes.add(n+7);
          Notes.noteOn(n+12);
          heldNotes.add(n+12);
        }
        else if (GlobalState.autoChord == 3) {
          Notes.noteOn(n+12);
          heldNotes.add(n+12);
        }
      }
    }
    //Chord Mode
    else {
      //Turn on the new note
      Notes.noteOn(n);
      heldNotes.add(n);
    }
  }
  void noteReleased(int n) {
    print("RELEASED");
    fingers --;
    //Legato Mode
    if (GlobalState.noteMode == 0 || GlobalState.noteMode == 2) {
      //If all fingers have been taken off, turn off all notes
      if (fingers == 0) {
        for (int i = 0; i < heldNotes.length; i ++) {
          int stop = heldNotes[i];
          Notes.noteOff(stop);
        }
        heldNotes.clear();
      }
    }
    //Chord Mode
    else {
      //Turn off the last note in the list
      if (heldNotes.length > 0) {
        int stop = heldNotes[heldNotes.length-1];
        Notes.noteOff(stop);
        heldNotes.removeAt(heldNotes.length-1);
      }
    }
  }
  void noteGlissando(int n) {
    //Clear all existing notes
    for (int i = 0; i < heldNotes.length; i ++) {
      int stop = heldNotes[i];
      Notes.noteOff(stop);
    }
    heldNotes.clear();

    //Turn on the new note
    if (n != -1) {
      Notes.noteOn(n);
      heldNotes.add(n);
    }
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
                steady = true;
              },
              onPointerUp: (details) {
                steady = false;
              },
              child: Container(
                width:MediaQuery.of(context).size.width/2,
                height:MediaQuery.of(context).size.height/10,
                decoration: BoxDecoration(color: Colors.red, border: Border.all()),
                padding: EdgeInsets.all(25),
                child: Text('Steady'),
              ),
            ),
            Listener(
              onPointerDown: (details) {
                glissando = true;
                noteGlissando(selNote());
              },
              onPointerUp: (details) {
                glissando = false;
                noteGlissando(-1);
              },
              child: Container(
                width:MediaQuery.of(context).size.width/2,
                height:MediaQuery.of(context).size.height/10,
                decoration: BoxDecoration(color: Colors.orange, border: Border.all()),
                padding: EdgeInsets.all(25),
                child: Text('Glissando'),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Listener(
              onPointerDown: (details) {
                notePressed(selNote());
              },
              onPointerUp: (details) {
                noteReleased(selNote());
              },
              child: Container(
                width:MediaQuery.of(context).size.width,
                height:MediaQuery.of(context).size.height/3,
                decoration: BoxDecoration(color: Colors.blue[50], border: Border.all()),
                padding: EdgeInsets.all(25),
                child: null,
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