import 'global_state.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart';
import 'dart:typed_data';
import 'dart:async';
import 'package:flutter_midi_command/flutter_midi_command.dart';
import 'package:flutter_midi_command/flutter_midi_command_messages.dart';
import 'package:soundpool/soundpool.dart';

class Notes {
  static Soundpool pool = Soundpool(maxStreams: 30);
  static void playOnboardSound(String path) async {
    path = "assets/sounds/" + path + ".mp3";
    int soundId = await rootBundle.load(path).then((ByteData soundData) {
      return pool.load(soundData);
    });
    await pool.play(soundId);
  }
  static void buildOnboardSound(int notenum) {
    String builtNote = "";
    int note = notenum % 12;
    int octave = (notenum~/12)-1;
    if (note == 0) {builtNote = "c";}
    if (note == 1) {builtNote = "c-";}
    if (note == 2) {builtNote = "d";}
    if (note == 3) {builtNote = "d-";}
    if (note == 4) {builtNote = "e";}
    if (note == 5) {builtNote = "f";}
    if (note == 6) {builtNote = "f-";}
    if (note == 7) {builtNote = "g";}
    if (note == 8) {builtNote = "g-";}
    if (note == 9) {builtNote = "a";}
    if (note == 10) {builtNote = "a-";}
    if (note == 11) {builtNote = "b";}
    if (octave <= 3) {builtNote += "3";}
    if (octave == 4) {builtNote += "4";}
    if (octave >= 5) {
      if (note == 9 || note == 10 || note == 11) {
        builtNote += "4";
      } else {
        builtNote += "5";
      }
    }
    playOnboardSound(builtNote);
  }
  static MidiCommand _midiCommand = MidiCommand();
  static bool usbInititalized = false;
  static List<MidiDevice> devices;
  static void processDevices(value) {
    //Update the global variables
    devices = value;
    print("There are " + devices.length.toString() + " devices available");

    //Connect to each device
    GlobalState.debugText = "";
    for (int i = 0; i < devices.length; i ++) {
      _midiCommand.connectToDevice(devices[i]);
      if (devices[i].connected) {
        //Debug
        GlobalState.debugText += "Connected to " + devices[i].name + "\n";
        print("Connected to " + devices[i].name + "\n");

        //Connect to Ports
        List<MidiPort> inPorts = devices[i].inputPorts;
        List<MidiPort> outPorts = devices[i].outputPorts;
        GlobalState.debugText += "  Input Ports: " + inPorts.length.toString() + "\n";
        GlobalState.debugText += "  Output Ports: " + outPorts.length.toString() + "\n";
      }
    }
  }

  static void usbInit() async {
    _midiCommand.teardown();
    usbInititalized = true;
    final deviceFuture = _midiCommand.devices;
    deviceFuture.then((value) => processDevices(value));
  }
  static void sendMIDICC(int control, int val) async {
    if (!usbInititalized) {
      usbInit();
    }
    CCMessage(
      channel:GlobalState.midiChannel,
      controller:control,
      value:val,
    ).send();
  }
  static void sendMIDINoteOn(int sentNote, {bool isDrum = false}) async {
    if (!usbInititalized) {
      usbInit();
    }
    NoteOnMessage(
        channel:isDrum?GlobalState.drumPadChannel:GlobalState.midiChannel,
        note:sentNote,
        velocity:GlobalState.noteVelocity,
    ).send();
  }
  static void sendMIDINoteOff(int sentNote, {bool isDrum = false}) async {
    if (!usbInititalized) {
      usbInit();
    }
    NoteOffMessage(
        channel:isDrum?GlobalState.drumPadChannel:GlobalState.midiChannel,
        note:sentNote,
        velocity:0,
    ).send();
  }
  static void noteOn(int note, {bool isDrum = false}){
    if (GlobalState.onboardSound == 1) {
      buildOnboardSound(note);
    } else {
      sendMIDINoteOn(note, isDrum:isDrum);
    }
  }
  static void noteOff(int note, {bool isDrum = false}){
    if (GlobalState.onboardSound != 1) {
      sendMIDINoteOff(note, isDrum:isDrum);
    }
  }
}