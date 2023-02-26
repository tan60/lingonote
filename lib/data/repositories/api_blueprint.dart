import 'package:lingonote/data/models/note_model.dart';

abstract class ApiBlueprint {
  Future<List<NoteModel>>? fetchMyNotes(int userUid);
  Future? postNote(NoteModel note);
}
