import 'package:lingonote/datas/models/achieve_model.dart';
import 'package:lingonote/datas/models/note_model.dart';
import 'package:lingonote/datas/repositories/base_service.dart';

class RemoteService extends BaseService {
  static RemoteService? _instance;

  factory RemoteService() {
    _instance ??= RemoteService._internal();
    return _instance!;
  }

  RemoteService._internal();

  @override
  Future<List<NoteModel>>? fetchMyNotes(int userUid) {
    return null;
  }

  @override
  Future? postNote(NoteModel note) {
    return null;
  }

  @override
  Future? updateNote(NoteModel note) {
    return null;
  }

  @override
  Future<int> fetchTotalPostedCount(int userUid) async {
    return 0;
  }

  @override
  Future<NoteModel>? fetchFirstNote(int userUid) {
    return null;
  }

  @override
  Future<List<AchieveModel>>? fetchAcheive(int userUid) {
    return null;
  }
}
