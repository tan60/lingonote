import 'package:flutter/material.dart';
import 'package:lingonote/domains/managers/pref_mgr.dart';
import 'package:lingonote/domains/managers/string_mgr.dart';
import 'package:lingonote/main.dart';
import 'package:sizer/sizer.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen>
    with WidgetsBindingObserver {
  bool _menuLangKr = true;
  bool _menuLangEn = false;

  bool _menuThemeSystem =
      (PrefMgr.prefs.getString(PrefMgr.theme) ?? 'system') == 'system';
  bool _menuThemeLight =
      (PrefMgr.prefs.getString(PrefMgr.theme) ?? 'system') == 'light';
  bool _menuThemeDark =
      (PrefMgr.prefs.getString(PrefMgr.theme) ?? 'system') == 'dark';

  void _handleMenuLangKr(bool value) {
    setState(() {
      _menuLangKr = value;
      _menuLangEn = !value;
    });
  }

  void _handleMenuLangEn(bool value) {
    setState(() {
      _menuLangKr = !value;
      _menuLangEn = value;
    });
  }

  void _handleMenuThemeSystem(bool value) {
    setState(() {
      if (value) {
        _menuThemeSystem = true;
        _menuThemeLight = false;
        _menuThemeDark = false;
        PrefMgr.prefs.setString(PrefMgr.theme, 'system');
        App.brightnessNotifier.value =
            WidgetsBinding.instance.window.platformBrightness;
      } else {
        _menuThemeSystem = false;
        _menuThemeLight = true;
        _menuThemeDark = false;
        PrefMgr.prefs.setString(PrefMgr.theme, 'light');
        App.brightnessNotifier.value = Brightness.light;
      }
    });
  }

  void _handleMenuThemeLight(bool value) {
    setState(() {
      if (value) {
        _menuThemeSystem = false;
        _menuThemeLight = true;
        _menuThemeDark = false;
        PrefMgr.prefs.setString(PrefMgr.theme, 'light');
        App.brightnessNotifier.value = Brightness.light;
      } else {
        _menuThemeSystem = true;
        _menuThemeLight = false;
        _menuThemeDark = false;
        PrefMgr.prefs.setString(PrefMgr.theme, 'system');
        App.brightnessNotifier.value =
            WidgetsBinding.instance.window.platformBrightness;
      }
    });
  }

  void _handleMenuThemeDark(bool value) {
    setState(() {
      if (value) {
        _menuThemeSystem = false;
        _menuThemeLight = false;
        _menuThemeDark = true;
        PrefMgr.prefs.setString(PrefMgr.theme, 'dark');
        App.brightnessNotifier.value = Brightness.dark;
      } else {
        _menuThemeSystem = true;
        _menuThemeLight = false;
        _menuThemeDark = false;
        PrefMgr.prefs.setString(PrefMgr.theme, 'system');
        App.brightnessNotifier.value =
            WidgetsBinding.instance.window.platformBrightness;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 82,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              StringMgr().settings,
              style: TextStyle(
                fontSize: 18.sp,
                color: Theme.of(context).textTheme.displayLarge!.color,
              ),
            ),
          ),
        ),
        leadingWidth: 92, // horizontal 52 + 40
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Ink(
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: SizedBox(
                    width: 32,
                    height: 32,
                    child: Icon(
                      Icons.close_rounded,
                      color: Theme.of(context).textTheme.displayLarge!.color,
                      size: 32,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              _buildLanguageSetting(context),
              const SizedBox(
                height: 20,
              ),
              _buildColorThemeSetting(context),
              const SizedBox(
                height: 20,
              ),
              _buildEtcSetting(context),
            ],
          ),
        ),
      ),
    );
  }

  Container _buildLanguageSetting(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            blurRadius: 18,
            offset: const Offset(0, 12),
            color: Colors.black.withOpacity(0.2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            StringMgr().languageSetTitle,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).textTheme.displayLarge!.color,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                flex: 7,
                child: Text(
                  StringMgr().languageKr,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).textTheme.displayLarge!.color,
                  ),
                ),
              ),
              Expanded(
                child: Switch(
                  value: _menuLangKr,
                  onChanged: (value) {
                    _handleMenuLangKr(value);
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 7,
                child: Text(
                  StringMgr().languageEn,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).textTheme.displayLarge!.color,
                  ),
                ),
              ),
              Expanded(
                child: Switch(
                  value: _menuLangEn,
                  onChanged: (value) {
                    _handleMenuLangEn(value);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container _buildColorThemeSetting(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            blurRadius: 18,
            offset: const Offset(0, 12),
            color: Colors.black.withOpacity(0.2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            StringMgr().brightThemeSetTitle,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).textTheme.displayLarge!.color,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                flex: 7,
                child: Text(
                  StringMgr().brightSystem,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).textTheme.displayLarge!.color,
                  ),
                ),
              ),
              Expanded(
                child: Switch(
                  value: _menuThemeSystem,
                  onChanged: (value) {
                    _handleMenuThemeSystem(value);
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 7,
                child: Text(
                  StringMgr().brightLight,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).textTheme.displayLarge!.color,
                  ),
                ),
              ),
              Expanded(
                child: Switch(
                  value: _menuThemeLight,
                  onChanged: (value) {
                    _handleMenuThemeLight(value);
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 7,
                child: Text(
                  StringMgr().brightDark,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).textTheme.displayLarge!.color,
                  ),
                ),
              ),
              Expanded(
                child: Switch(
                  value: _menuThemeDark,
                  onChanged: (value) {
                    _handleMenuThemeDark(value);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container _buildEtcSetting(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            blurRadius: 18,
            offset: const Offset(0, 12),
            color: Colors.black.withOpacity(0.2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            StringMgr().appName,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).textTheme.displayLarge!.color,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Material(
            color: Theme.of(context).cardColor,
            child: InkWell(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      StringMgr().rateApp,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).textTheme.displayLarge!.color,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
          ),
          Material(
            color: Theme.of(context).cardColor,
            child: InkWell(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      StringMgr().shareApp,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).textTheme.displayLarge!.color,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
          ),
          Material(
            color: Theme.of(context).cardColor,
            child: InkWell(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      StringMgr().questionDeveloper,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).textTheme.displayLarge!.color,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/***
 * 메뉴 언어 설정
 * - 한글
 * - 영어
 * 컬러 테마 설정
 * - 시스템 밝기
 * - 라이트 모드
 * - 다크 모드
 * 연락
 * - 평가하기
 * - 개발자에게 문의하기
 * 
 */
