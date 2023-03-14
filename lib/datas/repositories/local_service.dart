import 'package:lingonote/datas/models/achieve_model.dart';
import 'package:lingonote/datas/models/note_model.dart';
import 'package:lingonote/datas/repositories/base_service.dart';
import 'package:lingonote/datas/repositories/database/database_helper.dart';

class LocalService extends BaseService {
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
  Future? updateNote(NoteModel note) {
    return DataBaseHelper().updateNote(note);
  }

  @override
  Future<int> fetchTotalPostedCount(int userUid) async {
    return DataBaseHelper().getTotalCountNotes();
  }

  @override
  Future<NoteModel>? fetchFirstNote(int userUid) {
    return DataBaseHelper().getFristNote(userUid);
  }

  @override
  Future<List<AchieveModel>>? fetchAcheive(int userUid) {
    return DataBaseHelper().getArchive(userUid);
  }
}
