class NoteModel {
  late final String topic,
      contents,
      issueDate,
      fixedDate,
      improved,
      improvedType;
  late final int userUid;
  late List<String> tags;
  late int postNo;

  NoteModel({
    required this.topic,
    required this.contents,
    required this.issueDate,
    required this.fixedDate,
    required this.improved,
    required this.improvedType,
    required this.userUid,
  });

  NoteModel.fromJson(Map<String, dynamic> json)
      : postNo = json['post_no'],
        topic = json['topic'],
        contents = json['contents'],
        issueDate = json['issue_date'], //20230227130155
        fixedDate = json['fixed_date'],
        userUid = json['user_uid'],
        improved = json['improved'],
        improvedType = json['improve_type'],
        tags = json['tags'].toList();
}
