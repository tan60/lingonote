import 'package:lingonote/datas/models/achieve_model.dart';
import 'package:lingonote/datas/models/note_model.dart';
import 'package:lingonote/datas/models/query_ai_model.dart';
import 'package:lingonote/datas/repositories/base_service.dart';

class Repo extends BaseService {
  final BaseService service;
  static Repo? _instance;

  late BaseService baseService;

  factory Repo(BaseService service) {
    _instance ??= Repo._internal(service);
    return _instance!;
  }

  Repo._internal(this.service) {
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
  Future? updateNote(NoteModel note) async {
    return await service.updateNote(note);
  }

  @override
  Future<int> fetchTotalPostedCount(int userUid) async {
    return await service.fetchTotalPostedCount(userUid);
  }

  @override
  Future<NoteModel>? fetchFirstNote(int userUid) async {
    return await service.fetchFirstNote(userUid)!;
  }

  @override
  Future<List<AchieveModel>>? fetchAcheive(int userUid) async {
    return await service.fetchAcheive(userUid)!;
  }

  @override
  Future? postCorrectQuery(QueryAIModel queryAIModel) async {
    return await service.postCorrectQuery(queryAIModel);
  }
}
