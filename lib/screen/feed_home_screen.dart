import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lingonote/data/models/note_model.dart';
import 'package:lingonote/data/repositories/base_repo.dart';
import 'package:lingonote/managers/string_manager.dart';
import 'package:lingonote/screen/edit_note_screen.dart';
import 'package:lingonote/widgets/note_widget.dart';

class FeedHomeScreen extends StatefulWidget {
  @override
  const FeedHomeScreen({super.key});

  @override
  State<FeedHomeScreen> createState() => FeedHomeScreenState();
}

class FeedHomeScreenState extends State<FeedHomeScreen> {
  Future<List<NoteModel>>? notes = BaseRepo().fetchMyNotes(
      1234567890123456 /* PrefMgr().prefs.getInt(PrefMgr.uid) ?? -1 */);

  void fetchNotes() {
    setState(() {
      notes = BaseRepo().fetchMyNotes(
          1234567890123456 /* PrefMgr().prefs.getInt(PrefMgr.uid) ?? -1 */);
    });
  }

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
        DateTime issueServerTime = DateTime.parse(note.issueDate);
        String formattedTime =
            DateFormat('yyyy.MM.dd HH:mm').format(issueServerTime);

        return Note(
          title: note.topic,
          contents: note.contents,
          date: formattedTime,
          improvedType: note.improvedType,
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
          buildTryNowButton(context),
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

  Ink buildTryNowButton(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        color: Colors.grey.shade200,
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const EditNoteScreen(),
              fullscreenDialog: true,
              allowSnapshotting: true,
            ),
          ).then(
            (value) {
              fetchNotes();
            },
          );
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
