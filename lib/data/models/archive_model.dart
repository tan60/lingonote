class ArchiveModel {
  late final String date;
  late final int postedCount;

  ArchiveModel({
    required this.date,
    required this.postedCount,
  });

  ArchiveModel.fromJson(Map<String, dynamic> json)
      : date = json['date'],
        postedCount = json['postedCount'];
}
