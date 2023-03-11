class NoteModel {
  late final String topic,
      contents,
      issueDate,
      issueDateTime,
      fixedDateTime,
      improved,
      improvedType;
  late final int userUid;
  late List<String> tags;
  late int postNo;

  NoteModel({
    required this.topic,
    required this.contents,
    required this.issueDate,
    required this.issueDateTime,
    required this.fixedDateTime,
    required this.improved,
    required this.improvedType,
    required this.userUid,
  });

  NoteModel.fromJson(Map<String, dynamic> json)
      : postNo = json['post_no'],
        topic = json['topic'],
        contents = json['contents'],
        issueDate = json['issue_date'], //yyyy-MM-dd
        issueDateTime = json['issue_date_time'], //yyyy-MM-dd hh:MM:ss
        fixedDateTime = json['fixed_date_time'], //yyyy-MM-dd hh:MM:ss
        userUid = json['user_uid'],
        improved = json['improved'],
        improvedType = json['improve_type'],
        tags = json['tags'].toList();
}
