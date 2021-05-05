import 'global_state.dart';
import 'package:soundpool/soundpool.dart';
import 'package:flutter/services.dart';

class Notes {
  static Soundpool pool = Soundpool(maxStreams: 30);
  static void playOnboardSound(String path) async {
    path = "assets/sounds/" + path + ".mp3";
    int soundId = await rootBundle.load(path).then((ByteData soundData) {
      return pool.load(soundData);
    });
    await pool.play(soundId);
  }
  static void noteOn(int notenum){
    if (GlobalState.onboardSound == 1) {
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
  }
  static void noteOff(int note){
    print("off");
  }
}