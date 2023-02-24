class NoteModel {
  late final String title, contents, issueDate, fixedDate, userId;
  late final bool isGrammatically, isImproved;
  late List<String> tags;

  NoteModel(
      {required this.title,
      required this.contents,
      required this.issueDate,
      required this.fixedDate,
      required this.userId,
      required this.isGrammatically,
      required this.isImproved});

  NoteModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        contents = json['contents'],
        issueDate = json['issueDate'], //20230227130155
        fixedDate = json['fixedDate'],
        userId = json['userId'],
        isGrammatically = json['isGrammatically'],
        isImproved = json['isImproved'],
        tags = json['tags'].toList();
}
