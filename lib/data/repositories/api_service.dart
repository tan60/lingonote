import 'package:lingonote/data/models/note_model.dart';
import 'package:lingonote/data/repositories/api_blueprint.dart';

class ApiService extends ApiBlueprint {
  static ApiService? _instance;

  factory ApiService() {
    _instance ??= ApiService._internal();
    return _instance!;
  }

  ApiService._internal();

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
}
