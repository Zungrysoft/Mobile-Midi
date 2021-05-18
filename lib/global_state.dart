import 'package:shared_preferences/shared_preferences.dart';

class GlobalState {
  static SharedPreferences preferences;

  static String infoText = "";
  static double sensitivity = 5.0;
  static int noteMode = 0;
  static int autoChord = 0;
  static int vibrationEnable = 1;
  static int onboardSound = 0;
  static int interpolateNoteWheel = 1;
  static int controlsMode = 0;

  static int midiChannel = 0;
  static int drumPadChannel = 10;
  static int noteVelocity = 127;

  static int CC1 = 127;
  static int CC2 = 127;
  static int CC3 = 127;
  static int CC4 = 127;
  static int CC5 = 127;
  static int CC1Set = 12;
  static int CC2Set = 13;
  static int CC3Set = 14;
  static int CC4Set = 15;
  static int CC5Set = 16;

  static String debugText = "";

  static void save() async {
    print("SAVE");
    preferences = await SharedPreferences.getInstance();
    preferences.setDouble('sensitivity', sensitivity);
    preferences.setInt('noteMode',noteMode);
    preferences.setInt('autoChord',autoChord);
    preferences.setInt('vibrationEnable',vibrationEnable);
    preferences.setInt('onboardSound',onboardSound);
    preferences.setInt('interpolateNoteWheel',interpolateNoteWheel);
    preferences.setInt('controlsMode',controlsMode);
    preferences.setInt('midiChannel',midiChannel);
    preferences.setInt('drumPadChannel',drumPadChannel);
    preferences.setInt('noteVelocity',noteVelocity);
    preferences.setInt('CC1Set',CC1Set);
    preferences.setInt('CC2Set',CC2Set);
    preferences.setInt('CC3Set',CC3Set);
    preferences.setInt('CC4Set',CC4Set);
    preferences.setInt('CC5Set',CC5Set);
  }

  static void load() async {
    print("LOAD");
    preferences = await SharedPreferences.getInstance();
    sensitivity = preferences.getDouble('sensitivity') ?? 5.0;
    noteMode = preferences.getInt('noteMode') ?? 0;
    autoChord = preferences.getInt('autoChord') ?? 0;
    vibrationEnable = preferences.getInt('vibrationEnable') ?? 1;
    onboardSound = preferences.getInt('onboardSound') ?? 0;
    interpolateNoteWheel = preferences.getInt('interpolateNoteWheel') ?? 1;
    controlsMode = preferences.getInt('controlsMode') ?? 0;
    midiChannel = preferences.getInt('midiChannel') ?? 0;
    drumPadChannel = preferences.getInt('drumPadChannel') ?? 10;
    noteVelocity = preferences.getInt('noteVelocity') ?? 127;
    CC1Set = preferences.getInt('CC1Set') ?? 12;
    CC2Set = preferences.getInt('CC2Set') ?? 13;
    CC3Set = preferences.getInt('CC3Set') ?? 14;
    CC4Set = preferences.getInt('CC4Set') ?? 15;
    CC5Set = preferences.getInt('CC5Set') ?? 16;

    print(preferences.getInt('vibrationEnable'));
  }
}