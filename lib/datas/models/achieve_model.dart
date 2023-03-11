class AchieveModel {
  late final String date;
  late final int postedCount;

  AchieveModel({
    required this.date,
    required this.postedCount,
  });

  AchieveModel.fromJson(Map<String, dynamic> json)
      : date = json['date'],
        postedCount = json['postedCount'];
}
