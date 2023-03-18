import 'package:intl/intl.dart';
import 'package:lingonote/datas/models/corrected_ai_model.dart';
import 'package:lingonote/datas/models/note_model.dart';
import 'package:lingonote/datas/models/query_ai_model.dart';
import 'package:lingonote/datas/repositories/local_service.dart';
import 'package:lingonote/datas/repositories/remote_service.dart';
import 'package:lingonote/domains/entities/note_entity.dart';
import 'package:lingonote/domains/managers/open_ai_mgr.dart';
import 'package:lingonote/domains/managers/pref_mgr.dart';

class PreviewUsecase {
  static PreviewUsecase? _instance;
  late final int userUid;

  factory PreviewUsecase() {
    _instance ??= PreviewUsecase._internal();
    return _instance!;
  }

  PreviewUsecase._internal() {
    userUid = PrefMgr.prefs.getInt(PrefMgr.uid) ?? -1;
  }

  Future<dynamic>? queryCorrectNote(NoteEntity queryNote) async {
    QueryAIModel queryAIModel = QueryAIModel(
      model: OpenAIMgr().model,
      instruction: OpenAIMgr().instruction,
      input: queryNote.contents,
    );

    CorrectedAIModel correctedAIModel =
        await RemoteService().postCorrectQuery(queryAIModel);

    if (correctedAIModel.choices.isNotEmpty) {
      queryNote.improved = correctedAIModel.choices[0].text;
      queryNote.improvedType = 'grammary'; // 'none' or 'grammary'
    }

    return queryNote;
  }

  Future updateNote(NoteEntity note) async {
    var now = DateTime.now();
    String issueDate = DateFormat('yyyy-MM-dd').format(now);
    String fixedDateTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);

    NoteModel noteModel = NoteModel(
      postNo: note.postNo,
      topic: note.topic,
      contents: note.contents,
      issueDate: issueDate,
      issueDateTime: note.dateTime,
      fixedDateTime: fixedDateTime,
      improved: note.improved,
      improvedType: note.improvedType,
      userUid: userUid,
    );

    NoteModel postedNote = await LocalService().updateNote(noteModel);

    return NoteEntity(
      postNo: postedNote.postNo,
      topic: postedNote.topic,
      contents: postedNote.contents,
      dateTime: postedNote.issueDateTime,
      improved: postedNote.improved,
      improvedType: postedNote.improvedType,
    );
  }
}
