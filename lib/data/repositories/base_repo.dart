import 'package:lingonote/data/models/note_model.dart';
import 'package:lingonote/data/repositories/api_blueprint.dart';
import 'package:lingonote/data/repositories/api_service.dart';
import 'package:lingonote/data/repositories/local_service.dart';
import 'package:lingonote/data/repositories/mock_service.dart';

class BaseRepo extends ApiBlueprint {
  final ApiService _apiService = ApiService();
  final LocalService _localService = LocalService();
  final MockService _mockService = MockService();
  late ApiBlueprint baseService;

  BaseRepo._internal();

  static final BaseRepo _singleton = BaseRepo._internal();

  factory BaseRepo() {
    return _singleton.initRepo();
  }

  BaseRepo initRepo() {
    baseService = _mockService; // Mock Service
    return _singleton;
  }

  @override
  Future<List<NoteModel>>? fetchMyNotes(int userUid) async {
    return await _localService.fetchMyNotes(userUid)!;
  }

  @override
  Future postNote(NoteModel note) async {
    return await _localService.postNote(note);
  }
}
