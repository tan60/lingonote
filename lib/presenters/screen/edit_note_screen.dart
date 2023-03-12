import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lingonote/domains/entities/note_entitiy.dart';
import 'package:lingonote/domains/managers/pref_mgr.dart';
import 'package:lingonote/domains/managers/string_mgr.dart';
import 'package:lingonote/domains/usecases/edit_usecase.dart';
import 'package:lingonote/presenters/widgets/edit_text_widget.dart';
import 'package:lingonote/presenters/widgets/preview_dialog_widget.dart';
import 'package:lingonote/presenters/widgets/rounded_icon_button_widget.dart';
import 'package:sizer/sizer.dart';

class EditNoteScreen extends StatefulWidget {
  const EditNoteScreen({
    super.key,
  });

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen>
    with WidgetsBindingObserver {
  late int userUid;
  late ScrollController _scrollController;
  late TextEditingController _topicTextEditingController;
  late TextEditingController _contentsTextEditingController;
  bool _isPreviewEnable = false;
  bool _isSaveEnable = false;
  bool _isPosting = false;

  @override
  void initState() {
    _scrollController = ScrollController();
    _topicTextEditingController = TextEditingController();
    _contentsTextEditingController = TextEditingController();

    WidgetsBinding.instance.addObserver(this);
    _getUid();

    super.initState();
  }

  Future _getUid() async {
    userUid = PrefMgr.prefs.getInt(PrefMgr.uid) ?? -1;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _scrollController.dispose();
    _topicTextEditingController.dispose();
    _contentsTextEditingController.dispose();
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    if (mounted) {
      setState(() {});
    }
  }

  void _setPreviewEnable(bool enable) {
    setState(() {
      _isPreviewEnable = enable;
    });
  }

  void _setSaveEnable(bool enable) {
    setState(() {
      _isSaveEnable = enable;
    });
  }

  void _setPostingState(bool isPosting) {
    setState(() {
      _isPosting = isPosting;
    });
  }

  void _showPostingResultAndPop(NoteEntitiy? note) {
    _setPostingState(false);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('작성 완료! AI로 향상된 표현을 배워보세요.'),
    ));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 82,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              StringMgr().editNoteAppBarTitle,
              style: TextStyle(
                fontSize: 18.sp,
                color: Colors.white,
              ),
            ),
          ),
        ),
        leadingWidth: 92, // horizontal 52 + 40
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: RoundedIconButton(
              iconData: Icons.close_rounded,
              enableColor: null,
              isEnable: true,
              isLoading: false,
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: EditText(
                      labelText: StringMgr().editTopicLabel,
                      hintText: StringMgr().editTopicHint,
                      maxLines: 3,
                      gestureTapCallback: null,
                      textEditingController: _topicTextEditingController,
                      onChanged: (string) {},
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    alignment: Alignment.topCenter,
                    height: 400,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: EditText(
                      labelText: StringMgr().editContentLabel,
                      hintText: StringMgr().editContentHint,
                      maxLines: null,
                      gestureTapCallback: () {
                        /* _scrollController.animateTo(
                          100.0,
                          duration: const Duration(microseconds: 500),
                          curve: Curves.ease,
                        ); */
                      },
                      textEditingController: _contentsTextEditingController,
                      onChanged: (string) {
                        _setPreviewEnable(string.isNotEmpty);
                        _setSaveEnable(string.isNotEmpty);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        width: 120,
        height: 52,
        child: Row(
          children: [
            RoundedIconButton(
              iconData: Icons.visibility_rounded,
              isEnable: _isPreviewEnable,
              isLoading: false,
              enableColor: null,
              onTap: () {
                _showPreviewDialog(_buildNote());
              },
            ),
            const SizedBox(
              width: 10,
            ),
            RoundedIconButton(
              iconData: Icons.task_alt_rounded,
              isEnable: _isSaveEnable,
              isLoading: _isPosting,
              enableColor: null,
              onTap: () async {
                _setPostingState(true);
                _showPostingResultAndPop(
                    await _postNote(context, _buildNote()));
                /* Future.delayed(const Duration(milliseconds: 2000), () {); */
              },
            ),
          ],
        ),
      ),
    );
  }

  NoteEntitiy _buildNote() {
    String topic = _topicTextEditingController.text;
    String contents = _contentsTextEditingController.text;
    String improved = "";
    String improvedType = "none";
    var now = DateTime.now();
    String issueDateTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);

    return NoteEntitiy(
      topic: topic,
      contents: contents,
      dateTime: issueDateTime,
      improved: improved,
      improvedType: improvedType,
    );
  }

  Future<NoteEntitiy>? _postNote(BuildContext context, NoteEntitiy note) async {
    return await EditUsecase().postNote(note);
  }

  Future<void> _showPreviewDialog(NoteEntitiy note) async {
    await showDialog(
      context: context,
      builder: (context) {
        return PreviewDialogWidget(note: note);
      },
    );
  }
}
