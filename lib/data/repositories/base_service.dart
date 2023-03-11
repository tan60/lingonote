import 'package:lingonote/data/models/archive_model.dart';
import 'package:lingonote/data/models/note_model.dart';

abstract class BaseService {
  Future<List<NoteModel>>? fetchMyNotes(int userUid);
  Future? postNote(NoteModel note);
  Future<int> fetchTotalPostedCount(int userUid);
  Future<NoteModel>? fetchFirstNote(int userUid);
  Future<List<ArchiveModel>>? fetchArchive(int userUid);
}
