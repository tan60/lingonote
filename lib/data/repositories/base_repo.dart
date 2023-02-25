import 'package:lingonote/data/models/note_model.dart';
import 'package:lingonote/data/repositories/api_blueprint.dart';
import 'package:lingonote/data/repositories/api_service.dart';
import 'package:lingonote/data/repositories/local_service.dart';
import 'package:lingonote/data/repositories/mock_service.dart';

class BaseRepo extends ApiBlueprint {
  late final ApiBlueprint baseService;
  final ApiService _apiService = ApiService();
  final LocalService _localService = LocalService();
  final MockService _mockService = MockService();

  BaseRepo._privateConstructor();

  static final BaseRepo _instance = BaseRepo._privateConstructor();

  factory BaseRepo() {
    return _instance.initRepo();
  }

  BaseRepo initRepo() {
    baseService = _mockService; // Mock Service
    return _instance;
  }

  @override
  Future<List<NoteModel>>? fetchMyNotes() async {
    return await Future<List<NoteModel>>.delayed(const Duration(seconds: 1),
        () {
      return baseService.fetchMyNotes()!;
    });
  }
}
