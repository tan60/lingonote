import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lingonote/data/models/note_model.dart';
import 'package:lingonote/data/repositories/base_repo.dart';
import 'package:lingonote/managers/pref_mgr.dart';
import 'package:lingonote/managers/string_mgr.dart';
import 'package:lingonote/themes/my_themes.dart';
import 'package:lingonote/widgets/edit_text_widget.dart';
import 'package:lingonote/widgets/preview_dialog_widget.dart';
import 'package:lingonote/widgets/rounded_icon_button_widget.dart';

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
  late Brightness _brightness;
  late ScrollController _scrollController;
  late TextEditingController _topicTextEditingController;
  late TextEditingController _contentsTextEditingController;
  bool _isPreviewEnable = false;
  bool _isSaveEnable = false;
  bool _isPosting = false;

  @override
  void initState() {
    getUid();
    WidgetsBinding.instance.addObserver(this);
    _brightness = WidgetsBinding.instance.window.platformBrightness;
    _scrollController = ScrollController();
    _topicTextEditingController = TextEditingController();
    _contentsTextEditingController = TextEditingController();

    super.initState();
  }

  Future getUid() async {
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
  void didChangeDependencies() {
    if (mounted) {
      setState(() {
        _brightness = WidgetsBinding.instance.window.platformBrightness;
      });
    }
    super.didChangeDependencies();
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

  void _showPostingResultAndPop(NoteModel? note) {
    _setPostingState(false);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('${note?.postNo} 번째 노트가 작성되었습니다.'),
    ));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _brightness == Brightness.light
          ? MyThemes.getThemeFromKey(MyThemeKeys.light).primaryColor
          : MyThemes.getThemeFromKey(MyThemeKeys.dark).canvasColor,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 82,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              StringMgr().editNoteAppBarTitle,
              style: const TextStyle(fontSize: 25, color: Colors.white),
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
        /* leading: Padding(
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
        ), */
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

  NoteModel _buildNote() {
    String topic = _topicTextEditingController.text;
    String contents = _contentsTextEditingController.text;
    String improved = "";
    String improvedType = "none";
    var now = DateTime.now();
    String issueDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
    String fixedData = issueDate;

    return NoteModel(
      topic: topic,
      contents: contents,
      issueDate: issueDate,
      fixedDate: fixedData,
      userUid: userUid,
      improved: improved,
      improvedType: improvedType,
    );
  }

  Future<NoteModel>? _postNote(BuildContext context, NoteModel note) async {
    NoteModel resultNote = await BaseRepo().postNote(note);
    return resultNote;
  }

  Future<void> _showPreviewDialog(NoteModel note) async {
    await showDialog(
      context: context,
      builder: (context) {
        return PreviewDialogWidget(note: note);
      },
    );
  }
}
