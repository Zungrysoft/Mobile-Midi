import 'global_state.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart';
import 'dart:typed_data';
import 'dart:async';
import 'package:flutter_midi_command/flutter_midi_command.dart';
import 'package:flutter_midi_command/flutter_midi_command_messages.dart';

class Notes {
  static void playOnboardSound(String path) async {
    print("No onboard sound!!");
  }
  static void buildOnboardSound(int notenum) {
    playOnboardSound("");
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
  static void sendMIDINoteOn(int sentNote) async {
    if (!usbInititalized) {
      usbInit();
    }
    NoteOnMessage(channel:0,note:sentNote,velocity:127).send();
  }
  static void sendMIDINoteOff(int sentNote) async {
    if (!usbInititalized) {
      usbInit();
    }
    NoteOffMessage(channel:0,note:sentNote,velocity:127).send();
  }
  static void noteOn(int note){
    if (GlobalState.onboardSound == 1) {
      buildOnboardSound(note);
    } else {
      sendMIDINoteOn(note);
    }
  }
  static void noteOff(int note){
    if (GlobalState.onboardSound != 1) {
      sendMIDINoteOff(note);
    }
  }
}