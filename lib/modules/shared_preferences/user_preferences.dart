import 'package:shared_preferences/shared_preferences.dart';

class userPreferences {
  static SharedPreferences? _preferences;

  static const keyTime = 'time';
  static const keyNoty = 'noty';

  int time = 30;
  int noty = 4;

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setTime(int time) async =>
      await _preferences?.setInt(keyTime, time);

  static int? getTime() => _preferences?.getInt(keyTime);

  static Future setNoty(int noty) async =>
      await _preferences?.setInt(keyNoty, noty);

  static int? getNoty() => _preferences?.getInt(keyNoty);
}
