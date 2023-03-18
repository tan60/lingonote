import 'package:lingonote/datas/models/note_model.dart';
import 'package:lingonote/datas/repositories/local_service.dart';
import 'package:lingonote/domains/entities/note_entity.dart';
import 'package:lingonote/domains/managers/pref_mgr.dart';

class NoteUsecase {
  static NoteUsecase? _instance;

  late final int userUid;

  factory NoteUsecase() {
    _instance ??= NoteUsecase._internal();
    return _instance!;
  }

  NoteUsecase._internal() {
    userUid = PrefMgr.prefs.getInt(PrefMgr.uid) ?? -1;
  }

  Future<List<NoteEntity>>? fetchMyNotes() async {
    List<NoteModel> notes = await LocalService().fetchMyNotes(userUid)!;

    return List.generate(notes.length, (i) {
      return NoteEntity(
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
