import 'package:lingonote/assets/languages/language_en.dart';
import 'package:lingonote/assets/languages/language_kr.dart';
import 'package:lingonote/assets/languages/languages.dart';

class StringMgr extends Languages {
  static final StringMgr _instance = StringMgr._privateConstructor();
  StringMgr._privateConstructor();
  late String locale;
  late Languages localeLanguage;

  factory StringMgr() {
    return _instance._initMgr();
  }

  StringMgr _initMgr() {
    locale = 'kr';

    switch (locale) {
      case 'kr':
        localeLanguage = LanguageKr();
        break;
      case 'en':
        localeLanguage = LanguageEn();
        break;
    }

    return _instance;
  }

  @override
  String get homeFeedGuide => localeLanguage.homeFeedGuide;

  @override
  String get homeFeedSubGuide => localeLanguage.homeFeedSubGuide;

  @override
  String get homeFeedAIGuide => localeLanguage.homeFeedAIGuide;

  @override
  String get tryWriting => localeLanguage.tryWriting;
}
