class OpenAIMgr {
  static final OpenAIMgr _instance = OpenAIMgr._internal();

  factory OpenAIMgr() {
    return _instance;
  }

  OpenAIMgr._internal();

  final String model = 'text-davinci-edit-001';
  final String instruction = 'correct grammary and sepelling only.';
  final String apiKey = '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';
}
