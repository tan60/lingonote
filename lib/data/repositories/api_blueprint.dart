import 'package:lingonote/data/models/note_model.dart';

abstract class ApiBlueprint {
  Future<List<NoteModel>>? fetchMyNotes(int userUid);
  Future? postNote(NoteModel note);
  Future<int> fetchTotalPostedCount(int userUid);
  Future<NoteModel>? fetchFirstNote(int userUid);
}
