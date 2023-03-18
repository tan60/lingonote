class QueryAIModel {
  late final String model;
  late final String input;
  late final String instruction;

  QueryAIModel({
    required this.model,
    required this.input,
    required this.instruction,
  });

  Map<String, dynamic> toJson() {
    return {
      'model': model,
      'input': input,
      'instruction': instruction,
    };
  }
}
