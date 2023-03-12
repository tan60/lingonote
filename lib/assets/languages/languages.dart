import 'package:flutter/widgets.dart';

abstract class Languages {
  static Languages of(BuildContext context) {
    return Localizations.of<Languages>(context, Languages)!;
  }

  String get appName;

  String get homeFeedGuide;

  String get homeFeedSubGuide;

  String get homeFeedAIGuide;

  String get tryWriting;

  String get editNoteAppBarTitle;

  String get editTopicLabel;

  String get editTopicHint;

  String get editContentLabel;

  String get editContentHint;

  String get correctedByAI;

  String get close;

  String get showCorrectedNote;

  String get showOriginalNote;

  String get your;

  String get accomplishments;

  String get encourage;

  String get settings;

  String get languageSetTitle;

  String get languageKr;

  String get languageEn;

  String get brightThemeSetTitle;

  String get brightSystem;

  String get brightLight;

  String get brightDark;

  String get rateApp;

  String get shareApp;

  String get questionDeveloper;
}
