import 'package:flutter/material.dart';
import 'package:lingonote/data/models/note_model.dart';
import 'package:lingonote/data/repositories/base_repo.dart';
import 'package:lingonote/managers/string_manager.dart';
import 'package:lingonote/widgets/note_widget.dart';

class FeedHomeScreen extends StatelessWidget {
  FeedHomeScreen({
    super.key,
  });

  final Future<List<NoteModel>>? notes = BaseRepo().baseService.fetchMyNotes();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 50,
      ),
      child: FutureBuilder(
        future: notes,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isNotEmpty) {
              // data exist
              return Column(
                children: [
                  Expanded(
                    child: buildNoteList(snapshot),
                  ),
                ],
              );
            } else {
              return buildHomeFeedGuide(context);
            }
          } else {
            return Container(
              alignment: Alignment.center,
              child: const Text('loading'),
            );
          }
        },
      ),
    );
  }

  ListView buildNoteList(AsyncSnapshot<List<NoteModel>> snapshot) {
    return ListView.separated(
      scrollDirection: Axis.vertical,
      itemCount: snapshot.data!.length,
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 10,
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
    );
  }

  Container buildHomeFeedGuide(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 26,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 120,
          ),
          Text(
            StringMgr().homeFeedSubGuide,
            style: const TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.w200,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            StringMgr().homeFeedGuide,
            style: const TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          const TryNowButton(),
          const SizedBox(
            height: 6,
          ),
          Container(
            padding: const EdgeInsets.only(
              right: 8,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  StringMgr().homeFeedAIGuide,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black87,
                    //color: MyThemes.lightTheme.primaryColor,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TryNowButton extends StatelessWidget {
  const TryNowButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        color: Colors.grey.shade200,
      ),
      child: InkWell(
        onTap: () {
          /* ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Tap'),
          )); */
        },
        child: Container(
          height: 64,
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
          ),
          child: Row(
            children: [
              const Icon(
                Icons.create_rounded,
                color: Colors.black87,
              ),
              const SizedBox(
                width: 14,
              ),
              Text(
                StringMgr().tryWriting,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
