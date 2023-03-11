import 'package:lingonote/datas/models/achieve_model.dart';
import 'package:lingonote/datas/models/note_model.dart';
import 'package:lingonote/datas/repositories/base_service.dart';
import 'package:lingonote/datas/repositories/local_service.dart';
import 'package:lingonote/domains/entities/achieve_entity.dart';
import 'package:lingonote/domains/entities/note_entitiy.dart';
import 'package:lingonote/domains/managers/pref_mgr.dart';

class AchieveUsecase {
  static AchieveUsecase? _instance;

  late final BaseService service;
  late final int userUid;

  factory AchieveUsecase() {
    _instance ??= AchieveUsecase._internal();

    return _instance!;
  }

  AchieveUsecase._internal() {
    service = LocalService();
    userUid = PrefMgr.prefs.getInt(PrefMgr.uid) ?? -1;
  }

  Future<int> fetchTotalPostedCount() async {
    return await service.fetchTotalPostedCount(userUid);
  }

  Future<NoteEntitiy>? fetchFirstNote() async {
    NoteModel note = await service.fetchFirstNote(userUid)!;

    return NoteEntitiy(
      topic: note.topic,
      contents: note.contents,
      dateTime: note.issueDateTime,
      improved: note.improved,
      improvedType: note.improvedType,
    );
  }

  Future<List<AchieveEntity>>? fetchAchieve() async {
    List<AchieveModel> achieves = await service.fetchAcheive(userUid)!;

    return List.generate(achieves.length, (i) {
      return AchieveEntity(
        date: achieves[i].date,
        postedCount: achieves[i].postedCount,
      );
    });
  }
}
