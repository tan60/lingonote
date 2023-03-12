import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer';

class PrefMgr {
  static const String uid = "uid";
  static const String theme = 'theme'; //system, light, dark
  static late SharedPreferences prefs;

  PrefMgr._internal();

  static Future<SharedPreferences> initPref() async {
    prefs = await SharedPreferences.getInstance();
    log('initPref -- await prefs');
    return prefs;
  }
}
