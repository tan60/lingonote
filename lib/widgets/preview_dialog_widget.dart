import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lingonote/data/models/note_model.dart';
import 'package:lingonote/managers/string_mgr.dart';

class PreviewDialogWidget extends StatelessWidget {
  final NoteModel note;
  const PreviewDialogWidget({
    super.key,
    required this.note,
  });

  @override
  Widget build(BuildContext context) {
    DateTime issueServerTime = DateTime.parse(note.issueDate);
    String formattedTime = DateFormat('yyyy.MM.dd').format(issueServerTime);
    bool isCorrected = note.improvedType == "none";

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(10),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topLeft,
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            width: double.infinity,
            height: 850,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Theme.of(context).dialogBackgroundColor),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '',
                      style: TextStyle(
                          fontSize: 16, color: Theme.of(context).disabledColor),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: SizedBox(
                        width: 32,
                        height: 32,
                        child: IconButton(
                          icon: const Icon(Icons.close_rounded),
                          color: Theme.of(context).dividerColor,
                          iconSize: 32,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                    /* TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ButtonStyle(
                          overlayColor: MaterialStateProperty.all(
                              Theme.of(context).highlightColor)),
                      child: Text(
                        StringMgr().close,
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).disabledColor,
                        ),
                      ),
                    ), */
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    note.topic,
                    style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).textTheme.displayLarge?.color),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      isCorrected ? StringMgr().showCorrectedNote : "",
                      style: TextStyle(
                        fontSize: 15,
                        color: isCorrected
                            ? Theme.of(context).primaryColor
                            : Theme.of(context).disabledColor,
                      ),
                    ),
                    Text(
                      formattedTime,
                      style: TextStyle(
                          fontSize: 15, color: Theme.of(context).disabledColor),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    child: Expanded(
                      child: Scrollbar(
                        thumbVisibility: false,
                        thickness: 3,
                        radius: const Radius.circular(20),
                        child: SingleChildScrollView(
                          child: Expanded(
                            child: Text(
                              note.contents,
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w300,
                                  color: Theme.of(context)
                                      .textTheme
                                      .displayLarge
                                      ?.color),
                            ),
                          ),
                        ),
                      ),
                    ),
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
