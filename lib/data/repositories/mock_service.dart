import 'package:lingonote/data/models/note_model.dart';
import 'package:lingonote/data/repositories/api_blueprint.dart';

class MockService extends ApiBlueprint {
  @override
  Future<List<NoteModel>>? fetchMyNotes() async {
    return await Future<List<NoteModel>>.delayed(const Duration(seconds: 1),
        () {
      List<NoteModel> notes = [];

      for (int i = 0; i < 15; i++) {
        NoteModel note = NoteModel(
          title: 'title $i',
          contents:
              'This is contents for dummy data, and it looks like card or stuff like that $i',
          issueDate: '202202271301',
          fixedDate: '202202271301',
          userId: 'user $i',
          isGrammatically: false,
          isImproved: true,
        );
        notes.add(note);
      }

      return notes;
    });
  }
}
