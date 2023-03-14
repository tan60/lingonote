import 'package:lingonote/datas/models/achieve_model.dart';
import 'package:lingonote/datas/models/note_model.dart';

abstract class BaseService {
  Future<List<NoteModel>>? fetchMyNotes(int userUid);
  Future? postNote(NoteModel note);
  Future? updateNote(NoteModel note);
  Future<int> fetchTotalPostedCount(int userUid);
  Future<NoteModel>? fetchFirstNote(int userUid);
  Future<List<AchieveModel>>? fetchAcheive(int userUid);
}
