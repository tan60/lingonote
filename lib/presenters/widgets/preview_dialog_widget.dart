import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lingonote/domains/entities/note_entitiy.dart';
import 'package:lingonote/domains/managers/string_mgr.dart';
import 'package:lingonote/presenters/screen/edit_note_screen.dart';
import 'package:sizer/sizer.dart';

enum ContentMode {
  original,
  improved,
}

class PreviewDialogWidget extends StatefulWidget {
  final NoteEntitiy note;
  final bool isEditable;

  const PreviewDialogWidget({
    super.key,
    required this.note,
    required this.isEditable,
  });

  @override
  State<PreviewDialogWidget> createState() => _PreviewDialogWidgetState();
}

class _PreviewDialogWidgetState extends State<PreviewDialogWidget> {
  ContentMode _contentMode = ContentMode.original;

  void changeContentMode(ContentMode mode) {
    setState(() {
      _contentMode = mode;
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime issueServerTime = DateTime.parse(widget.note.dateTime);
    String formattedTime = DateFormat('yyyy.MM.dd').format(issueServerTime);

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
          Stack(
            children: [
              Container(
                alignment: Alignment.topLeft,
                width: double.infinity,
                height: 850,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Theme.of(context).scaffoldBackgroundColor),
                padding: const EdgeInsets.fromLTRB(15, 15, 15, 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Builder(
                      builder: (context) {
                        return widget.isEditable
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 8, 0),
                                    child: SizedBox(
                                      width: 32,
                                      height: 32,
                                      child: IconButton(
                                        icon:
                                            const Icon(Icons.edit_note_rounded),
                                        color: Theme.of(context).focusColor,
                                        iconSize: 32,
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  EditNoteScreen(
                                                      currentNote: widget.note),
                                              fullscreenDialog: true,
                                              allowSnapshotting: true,
                                            ),
                                          ).then((value) {
                                            //Navigator.pop(context, true);
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Container();
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        widget.note.topic,
                        style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context)
                                .textTheme
                                .displayLarge
                                ?.color),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            PreviewFlatButton(
                              text: StringMgr().showOriginalNote,
                              color: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                  .color!,
                              onTap: () {
                                changeContentMode(ContentMode.original);
                              },
                              isSelected: _contentMode == ContentMode.original,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            PreviewFlatButton(
                              text: StringMgr().correctedByAI,
                              color: Theme.of(context).primaryColor,
                              onTap: () {
                                changeContentMode(ContentMode.improved);
                              },
                              isSelected: _contentMode == ContentMode.improved,
                            ),
                          ],
                        ),
                        Text(
                          formattedTime,
                          style: TextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w300,
                              color: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                  .color!),
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
                                  widget.note.contents,
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
              Container(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 20, 20, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 22,
                        height: 22,
                        child: IconButton(
                          icon: const Icon(Icons.delete),
                          color: Theme.of(context).focusColor,
                          iconSize: 22,
                          onPressed: () {
                            //show delete popup
                          },
                        ),
                      ),
                      SizedBox(
                        width: 32,
                        height: 32,
                        child: IconButton(
                          icon: const Icon(Icons.keyboard_arrow_down_outlined),
                          color: Theme.of(context).focusColor,
                          iconSize: 32,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PreviewFlatButton extends StatefulWidget {
  final String text;
  final Color color;
  final Function()? onTap;
  final bool isSelected;

  const PreviewFlatButton({
    super.key,
    required this.text,
    required this.color,
    required this.onTap,
    required this.isSelected,
  });

  @override
  State<PreviewFlatButton> createState() => _PreviewFlatButtonState();
}

class _PreviewFlatButtonState extends State<PreviewFlatButton> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: InkWell(
        onTap: widget.isSelected ? null : widget.onTap,
        child: SizedBox(
          height: 20,
          child: Row(
            children: [
              Icon(
                Icons.check_circle_outline_sharp,
                color: widget.isSelected
                    ? Colors.green
                    : Theme.of(context).highlightColor,
                size: 15,
              ),
              const SizedBox(
                width: 3,
              ),
              Text(
                widget.text,
                style: TextStyle(
                  fontSize: 10.sp,
                  color: widget.color,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
