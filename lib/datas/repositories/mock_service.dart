import 'package:lingonote/datas/models/achieve_model.dart';
import 'package:lingonote/datas/models/note_model.dart';
import 'package:lingonote/datas/repositories/base_service.dart';

class MockService extends BaseService {
  static MockService? _instance;

  factory MockService() {
    _instance ??= MockService._internal();
    return _instance!;
  }

  MockService._internal();

  @override
  Future<List<NoteModel>>? fetchMyNotes(int userUid) async {
    return await Future<List<NoteModel>>.delayed(const Duration(seconds: 1),
        () {
      List<NoteModel> notes = [];

      for (int i = 0; i < 15; i++) {
        NoteModel note = NoteModel(
          topic: 'title $i',
          contents:
              'This is contents for dummy data, and it looks like card or stuff like that $i',
          issueDate: '20220222',
          issueDateTime: '202202271301',
          fixedDateTime: '202202271301',
          userUid: userUid,
          improved: "",
          improvedType: "",
        );
        notes.add(note);
      }

      return notes;
    });
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
  Future<List<AchieveModel>>? fetchAcheive(int userUid) {
    return null;
  }
}
