import 'package:lingonote/assets/languages/languages.dart';

class LanguageEn extends Languages {
  @override
  String get homeFeedGuide => "하루 영작";

  @override
  String get homeFeedSubGuide => "매일 꾸준한 영작으로 당신의 영어 실력을 향상 시키세요.";

  @override
  String get homeFeedAIGuide => 'AI 교정을 통해 오류를 교정하고 더 나은 표현을 익힐 수 있어요.';

  @override
  String get tryWriting => '지금 시작해 볼까요?';

  @override
  String get editNoteAppBarTitle => "Let's write in English!";

  @override
  String get editTopicLabel => "What is topic of your writing?";

  @override
  String get editTopicHint => "Topic";

  @override
  String get editContentLabel => "Please write the content.";

  @override
  String get editContentHint => "Content";
}
