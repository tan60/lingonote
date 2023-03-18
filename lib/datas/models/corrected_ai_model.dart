class CorrectedAIModel {
  late final String object;
  late final int created;
  late final List<Choice> choices;
  late final Usages usages;

  CorrectedAIModel({
    required this.object,
    required this.created,
    required this.choices,
    required this.usages,
  });

  CorrectedAIModel.fromJson(Map<String, dynamic> json)
      : object = json['object'],
        created = json['created'],
        choices = (json['choices'] as List)
            .map((choiceJson) => Choice.fromJson(choiceJson))
            .toList(),
        usages = Usages.fromJson(json['usage']);
}

class Choice {
  late final String text;
  late final int index;

  Choice.fromJson(Map<String, dynamic> json)
      : text = json['text'],
        index = json['index'];
}

class Usages {
  late final int promptTokens;
  late final int completionTokens;
  late final int totalToken;

  Usages.fromJson(Map<String, dynamic> json)
      : promptTokens = json['prompt_tokens'],
        completionTokens = json['completion_tokens'],
        totalToken = json['total_tokens'];
}
