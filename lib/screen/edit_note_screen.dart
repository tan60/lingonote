import 'package:flutter/material.dart';
import 'package:lingonote/managers/string_manager.dart';
import 'package:lingonote/themes/my_themes.dart';
import 'package:lingonote/widgets/edit_text_widget.dart';
import 'package:lingonote/widgets/rounded_icon_button_widget.dart';

class EditNote extends StatefulWidget {
  const EditNote({super.key});

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> with WidgetsBindingObserver {
  late Brightness _brightness;
  late ScrollController _scrollController;
  bool isPreviewEnable = false;
  bool isSaveEnable = false;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    _brightness = WidgetsBinding.instance.window.platformBrightness;
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
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

  void setPreviewEnable(bool enable) {
    setState(() {
      isPreviewEnable = enable;
    });
  }

  void setSaveEnable(bool enable) {
    setState(() {
      isSaveEnable = enable;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _brightness == Brightness.light
          ? MyThemes.getThemeFromKey(MyThemeKeys.LIGHT).primaryColor
          : MyThemes.getThemeFromKey(MyThemeKeys.DARK).primaryColor,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 82,
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            StringMgr().editNoteAppBarTitle,
            style: const TextStyle(fontSize: 25, color: Colors.white),
          ),
        ),
        leadingWidth: 92, // horizontal 52 + 40
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: RoundedIconButton(
              iconData: Icons.close_rounded,
              enableColor: null,
              isEnable: true,
              onTap: () {}),
        ),
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
                      labelText: 'What is topic of your writing?',
                      hintText: 'Topic',
                      maxLines: 3,
                      gestureTapCallback: null,
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
                      labelText: 'Please write the content.',
                      hintText: 'Content',
                      maxLines: null,
                      gestureTapCallback: () {
                        /* _scrollController.animateTo(
                          100.0,
                          duration: const Duration(microseconds: 500),
                          curve: Curves.ease,
                        ); */
                      },
                      onChanged: (string) {
                        setPreviewEnable(string.isNotEmpty);
                        setSaveEnable(string.isNotEmpty);
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
              isEnable: isPreviewEnable,
              enableColor: null, //MyThemes.lightTheme.colorScheme.error,
              onTap: () {
                setPreviewEnable(false);
              },
            ),
            const SizedBox(
              width: 10,
            ),
            RoundedIconButton(
              iconData: Icons.task_alt_rounded,
              isEnable: isSaveEnable,
              enableColor: null, //MyThemes.lightTheme.colorScheme.error,
              onTap: () {
                setSaveEnable(false);
              },
            ),
          ],
        ),
      ),
    );
  }
}
