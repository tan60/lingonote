import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer';

class PrefMgr {
  static const String uid = "uid";
  //static final PrefMgr _singleton = PrefMgr._internal();
  static late SharedPreferences prefs;

  /* factory PrefMgr() {
    return _singleton;
  } */

  PrefMgr._internal();

  static Future<SharedPreferences> initPref() async {
    prefs = await SharedPreferences.getInstance();
    log('initPref -- await prefs');
    return prefs;
  }
}
