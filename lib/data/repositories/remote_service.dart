import 'package:lingonote/data/models/archive_model.dart';
import 'package:lingonote/data/models/note_model.dart';
import 'package:lingonote/data/repositories/base_service.dart';

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
  Future<int> fetchTotalPostedCount(int userUid) async {
    return 0;
  }

  @override
  Future<NoteModel>? fetchFirstNote(int userUid) {
    return null;
  }

  @override
  Future<List<ArchiveModel>>? fetchArchive(int userUid) {
    return null;
  }
}
