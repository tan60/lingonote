import 'package:lingonote/data/models/note_model.dart';
import 'package:lingonote/data/repositories/api_blueprint.dart';
import 'package:lingonote/data/repositories/database/database_helper.dart';

class LocalService extends ApiBlueprint {
  @override
  Future<List<NoteModel>>? fetchMyNotes(int userUid) {
    return DataBaseHelper().getNotes(userUid);
  }

  @override
  Future postNote(NoteModel note) {
    return DataBaseHelper().addNote(note);
  }
}
