import 'package:flutter/material.dart';
import 'package:lingonote/data/models/note_model.dart';
import 'package:lingonote/data/repositories/base_repo.dart';
import 'package:lingonote/widgets/note.dart';

class FeedHomeScreen extends StatelessWidget {
  FeedHomeScreen({
    super.key,
  });

  final Future<List<NoteModel>>? notes = BaseRepo().baseService.fetchMyNotes();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: FutureBuilder(
        future: notes,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Expanded(
                  child: ListView.separated(
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data!.length,
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                    itemBuilder: (context, index) {
                      var note = snapshot.data![index];
                      return Note(
                        title: note.title,
                        contents: note.contents,
                        date: note.issueDate,
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 24,
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Container(
              child: const Text('empty'),
            );
          }
        },
      ),
    );
  }
}
