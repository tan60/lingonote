import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lingonote/data/models/note_model.dart';
import 'package:lingonote/managers/string_mgr.dart';
import 'package:sizer/sizer.dart';

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
      insetPadding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
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
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: SizedBox(
                        width: 32,
                        height: 32,
                        child: IconButton(
                          icon: const Icon(Icons.close_rounded),
                          color: Theme.of(context).focusColor,
                          iconSize: 32,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    note.topic,
                    style: TextStyle(
                        fontSize: 22.sp,
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
                        fontSize: 10.sp,
                        color: isCorrected
                            ? Theme.of(context).primaryColor
                            : Theme.of(context).disabledColor,
                      ),
                    ),
                    Text(
                      formattedTime,
                      style: TextStyle(
                          fontSize: 10.sp,
                          color: Theme.of(context).disabledColor),
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
                                  fontSize: 18.sp,
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
