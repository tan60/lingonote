import 'package:lingonote/data/models/note_model.dart';
import 'package:lingonote/data/repositories/api_blueprint.dart';

class LocalService extends ApiBlueprint {
  @override
  Future<List<NoteModel>>? fetchMyNotes() {
    return null;
  }
}
