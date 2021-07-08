import 'package:shared_preferences/shared_preferences.dart';

class PreferenceUser {
  static final PreferenceUser __instance = PreferenceUser._internal();
  factory PreferenceUser() {
    return __instance;
  }
  PreferenceUser._internal();

  SharedPreferences _prefs;
  initPref() async {
    _prefs = await SharedPreferences.getInstance();
  }
  get token {}

  get typeLayout {
    return _prefs.getBool('isGrid') ?? true;
  }
  set typeLayout(bool value) {
    _prefs.setBool('isGrid', value);
  }
}