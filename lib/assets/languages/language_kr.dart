import 'package:lingonote/assets/languages/languages.dart';

class LanguageKr extends Languages {
  @override
  String get homeFeedGuide => "하루 영작";

  @override
  String get homeFeedSubGuide => "꾸준한 작문으로\n당신의 영어를\n향상 시켜보세요.";

  @override
  String get homeFeedAIGuide => 'AI 교정으로 더 나은 표현을 익혀보세요.';

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

  @override
  String get correctedByAI => "corrected by AI";

  @override
  String get close => "Close";

  @override
  String get showCorrectedNote => "AI Corrected";

  @override
  String get showOriginalNote => "Original";
}
