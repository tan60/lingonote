import 'package:lingonote/datas/models/note_model.dart';
import 'package:lingonote/datas/repositories/base_service.dart';
import 'package:lingonote/datas/repositories/local_service.dart';
import 'package:lingonote/domains/entities/note_entitiy.dart';
import 'package:lingonote/domains/managers/pref_mgr.dart';

class NoteUsecase {
  static NoteUsecase? _instance;
  late final BaseService service;
  late final int userUid;

  factory NoteUsecase() {
    _instance ??= NoteUsecase._internal();
    return _instance!;
  }

  NoteUsecase._internal() {
    service = LocalService();
    userUid = PrefMgr.prefs.getInt(PrefMgr.uid) ?? -1;
  }

  Future<List<NoteEntitiy>>? fetchMyNotes() async {
    List<NoteModel> notes = await service.fetchMyNotes(userUid)!;

    return List.generate(notes.length, (i) {
      return NoteEntitiy(
        postNo: notes[i].postNo,
        topic: notes[i].topic,
        contents: notes[i].contents,
        dateTime: notes[i].issueDateTime,
        improved: notes[i].improved,
        improvedType: notes[i].improvedType,
      );
    });
  }
}
