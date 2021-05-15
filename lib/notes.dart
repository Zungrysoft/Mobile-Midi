import 'global_state.dart';
import 'package:soundpool/soundpool.dart';
import 'package:flutter/services.dart';
import 'package:flutter_usb_write/flutter_usb_write.dart';
import 'package:flutter/services.dart';
import 'dart:typed_data';
import 'dart:async';

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
    if (octave >= 5) {builtNote += "5";}
    if (octave >= 6 && note == 0) {builtNote += "6";}
    playOnboardSound(builtNote);
  }
  static bool usbInititalized = false;
  static FlutterUsbWrite _flutterUsbWrite = FlutterUsbWrite();
  static StreamSubscription<UsbEvent> _usbStateSubscription;
  static Future<UsbDevice> _connect(UsbDevice device) async {
    try {
      var result = await _flutterUsbWrite.open(
        vendorId: device.vid,
        productId: device.pid,
      );
      return result;
    } on PermissionException {
      print("Not allowed to do that");
      return null;
    } on PlatformException catch (e) {
      print(e.message);
      return null;
    }
  }
  static void usbInit() async {
    if (usbInititalized == false) {
      List<UsbDevice> devices;
      try {
        devices = await _flutterUsbWrite.listDevices();
        _connect(devices[0]);
      } on PlatformException catch (e) {
        print(e.message);
      }
    }
    usbInititalized = false;
  }
  static void sendMIDINoteOn(int note) async {
    usbInit();
    List<int> data = [144,62,127];
    print(Uint8List.fromList(data));
    bool result = await _flutterUsbWrite.write(Uint8List.fromList(data));
    if (result == false) {
      print("FAILED TO WRITE");
    }
  }
  static void noteOn(int note){
    if (GlobalState.onboardSound == 1) {
      buildOnboardSound(note);
    } else {
      sendMIDINoteOn(note);
    }
  }
  static void noteOff(int note){
    print("off");
  }
}