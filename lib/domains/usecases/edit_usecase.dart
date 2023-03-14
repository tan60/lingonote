import 'package:intl/intl.dart';
import 'package:lingonote/datas/models/note_model.dart';
import 'package:lingonote/datas/repositories/base_service.dart';
import 'package:lingonote/datas/repositories/local_service.dart';
import 'package:lingonote/domains/entities/note_entitiy.dart';
import 'package:lingonote/domains/managers/pref_mgr.dart';

class EditUsecase {
  static EditUsecase? _instance;
  late final BaseService service;
  late final int userUid;

  factory EditUsecase() {
    _instance ??= EditUsecase._internal();

    return _instance!;
  }

  EditUsecase._internal() {
    service = LocalService();
    userUid = PrefMgr.prefs.getInt(PrefMgr.uid) ?? -1;
  }

  Future postOrUpdateNote(NoteEntitiy note) async {
    var now = DateTime.now();
    String issueDate = DateFormat('yyyy-MM-dd').format(now);

    NoteModel noteModel = NoteModel(
      postNo: note.postNo,
      topic: note.topic,
      contents: note.contents,
      issueDate: issueDate,
      issueDateTime: note.dateTime,
      fixedDateTime: note.dateTime,
      improved: note.improved,
      improvedType: note.improvedType,
      userUid: userUid,
    );

    NoteModel postedNote;

    if (note.postNo == null) {
      postedNote = await service.postNote(noteModel);
    } else {
      postedNote = await service.updateNote(noteModel);
    }

    return NoteEntitiy(
      postNo: postedNote.postNo,
      topic: postedNote.topic,
      contents: postedNote.contents,
      dateTime: postedNote.issueDateTime,
      improved: postedNote.improved,
      improvedType: postedNote.improvedType,
    );
  }

  Future updateNote(NoteEntitiy note) async {
    var now = DateTime.now();
    String issueDate = DateFormat('yyyy-MM-dd').format(now);

    NoteModel noteModel = NoteModel(
      postNo: note.postNo,
      topic: note.topic,
      contents: note.contents,
      issueDate: issueDate,
      issueDateTime: note.dateTime,
      fixedDateTime: note.dateTime,
      improved: note.improved,
      improvedType: note.improvedType,
      userUid: userUid,
    );

    NoteModel postedNote = await service.updateNote(noteModel);

    return NoteEntitiy(
      postNo: postedNote.postNo,
      topic: postedNote.topic,
      contents: postedNote.contents,
      dateTime: postedNote.issueDateTime,
      improved: postedNote.improved,
      improvedType: postedNote.improvedType,
    );
  }
}
