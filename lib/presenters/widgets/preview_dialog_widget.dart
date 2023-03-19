import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lingonote/domains/entities/note_entity.dart';
import 'package:lingonote/domains/managers/string_mgr.dart';
import 'package:lingonote/domains/usecases/preivew_usecase.dart';
import 'package:lingonote/presenters/screen/edit_note_screen.dart';
import 'package:sizer/sizer.dart';

enum ContentMode {
  original,
  improved,
}

class PreviewDialogWidget extends StatefulWidget {
  final NoteEntity note;
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
  String _content = "";
  bool isShowRefreshButton = false;

  void _changeContentMode(ContentMode mode) async {
    setState(() {
      _contentMode = mode;

      if (mode == ContentMode.original) {
        _content = widget.note.contents;
      } else {
        /* if (widget.note.improvedType == 'grammary') {
          _content = widget.note.improved;
        } else */
        {
          _content = 'Please wating for response from ChatGPT.';
          _queryCorrect();
        }
      }
    });
  }

  void _queryCorrect() async {
    final NoteEntity correctedNote =
        await PreviewUsecase().queryCorrectNote(widget.note);
    String content = '';
    if (correctedNote.improvedType == 'grammary') {
      widget.note.improved = correctedNote.improved;
      widget.note.improvedType = correctedNote.improvedType;
      content = correctedNote.improved;

      PreviewUsecase().updateNote(widget.note);
    } else {
      content = 'Sorry, try next time';
    }

    setState(() {
      _content = content;
    });
  }

  @override
  void initState() {
    super.initState();
    _changeContentMode(ContentMode.original);
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
                                _changeContentMode(ContentMode.original);
                              },
                              isSelected: _contentMode == ContentMode.original,
                              enableRetry: false,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Row(
                              children: [
                                PreviewFlatButton(
                                  text: StringMgr().correctedByAI,
                                  color: Theme.of(context).primaryColor,
                                  onTap: () {
                                    _changeContentMode(ContentMode.improved);
                                  },
                                  isSelected:
                                      _contentMode == ContentMode.improved,
                                  enableRetry: true,
                                ),
                              ],
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
                        child: Scrollbar(
                          thumbVisibility: false,
                          thickness: 3,
                          radius: const Radius.circular(20),
                          child: SingleChildScrollView(
                            child: Text(
                              _content,
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
                            _showDeleteDialog();
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
                            Navigator.pop(context, true);
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

  Future<void> _showDeleteDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0), // 원하는 radius 값으로 변경 가능
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Do you really want to delete it?',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.displayLarge!.color!,
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

class PreviewFlatButton extends StatefulWidget {
  final String text;
  final Color color;
  final Function()? onTap;
  final bool isSelected;
  final bool enableRetry;

  const PreviewFlatButton({
    super.key,
    required this.text,
    required this.color,
    required this.onTap,
    required this.isSelected,
    required this.enableRetry,
  });

  @override
  State<PreviewFlatButton> createState() => _PreviewFlatButtonState();
}

class _PreviewFlatButtonState extends State<PreviewFlatButton> {
  final bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: InkWell(
        onTap: widget.isSelected && !widget.enableRetry ? null : widget.onTap,
        child: SizedBox(
          height: 30,
          child: Row(
            children: [
              Icon(
                Icons.check_circle_outline_sharp,
                color: widget.isSelected
                    ? Colors.green
                    : Theme.of(context).highlightColor,
                size: 20,
              ),
              const SizedBox(
                width: 3,
              ),
              Text(
                widget.text,
                style: TextStyle(
                  fontSize: 11.sp,
                  color: widget.color,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(
                width: 3,
              ),
              Builder(builder: (context) {
                if (widget.enableRetry) {
                  return Icon(
                    Icons.refresh_outlined,
                    color: widget.isSelected
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).highlightColor,
                    size: 20,
                  );
                } else {
                  return Container();
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}
