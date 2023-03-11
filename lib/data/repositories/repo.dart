import 'package:lingonote/data/models/archive_model.dart';
import 'package:lingonote/data/models/note_model.dart';
import 'package:lingonote/data/repositories/base_service.dart';

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
  Future<int> fetchTotalPostedCount(int userUid) async {
    return await service.fetchTotalPostedCount(userUid);
  }

  @override
  Future<NoteModel>? fetchFirstNote(int userUid) async {
    return await service.fetchFirstNote(userUid)!;
  }

  @override
  Future<List<ArchiveModel>>? fetchArchive(int userUid) async {
    return await service.fetchArchive(userUid)!;
  }
}
