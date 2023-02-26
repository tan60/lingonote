import 'package:shared_preferences/shared_preferences.dart';

class PrefMgr {
  static const String uid = "uid";
  static final PrefMgr _singleton = PrefMgr._internal();
  late SharedPreferences prefs;

  factory PrefMgr() {
    return _singleton;
  }

  PrefMgr._internal();

  Future<SharedPreferences> initPref() async {
    prefs = await SharedPreferences.getInstance();
    return prefs;
  }
}
