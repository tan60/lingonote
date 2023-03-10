import 'package:lingonote/data/models/note_model.dart';
import 'package:lingonote/data/repositories/api_blueprint.dart';

class BaseRepo extends ApiBlueprint {
  final ApiBlueprint service;
  static BaseRepo? _instance;

  late ApiBlueprint baseService;

  factory BaseRepo(ApiBlueprint service) {
    _instance ??= BaseRepo._internal(service);
    return _instance!;
  }

  BaseRepo._internal(this.service) {
    baseService = service;
  }

  @override
  Future<List<NoteModel>>? fetchMyNotes(int userUid) async {
    return await service.fetchMyNotes(userUid)!;
  }

  @override
  Future postNote(NoteModel note) async {
    return await service.postNote(note);
  }

  @override
  Future<int> fetchTotalPostedCount(int userUid) async {
    return await service.fetchTotalPostedCount(userUid);
  }

  @override
  Future<NoteModel>? fetchFirstNote(int userUid) async {
    return await service.fetchFirstNote(userUid)!;
  }
}
