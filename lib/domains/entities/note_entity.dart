class NoteEntity {
  late final int? postNo;
  late final String topic;
  late final String contents;
  late final String dateTime;
  late String improved;
  late String improvedType;

  NoteEntity({
    required this.postNo,
    required this.topic,
    required this.contents,
    required this.dateTime,
    required this.improved,
    required this.improvedType,
  });
}
