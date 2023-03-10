import 'package:lingonote/data/models/note_model.dart';
import 'package:lingonote/data/repositories/api_blueprint.dart';
import 'package:lingonote/data/repositories/database/database_helper.dart';

class LocalService extends ApiBlueprint {
  static LocalService? _instance;

  factory LocalService() {
    _instance ??= LocalService._internal();
    return _instance!;
  }

  LocalService._internal();

  @override
  Future<List<NoteModel>>? fetchMyNotes(int userUid) {
    return DataBaseHelper().getNotes(userUid);
  }

  @override
  Future postNote(NoteModel note) {
    return DataBaseHelper().addNote(note);
  }

  @override
  Future<int> fetchTotalPostedCount(int userUid) async {
    return DataBaseHelper().getTotalCountNotes();
  }

  @override
  Future<NoteModel>? fetchFirstNote(int userUid) {
    return DataBaseHelper().getFristNote(userUid);
  }
}
