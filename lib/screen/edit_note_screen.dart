import 'package:flutter/material.dart';
import 'package:lingonote/themes/my_themes.dart';
import 'package:lingonote/widgets/appbar_close_button_widget.dart';
import 'package:lingonote/widgets/edit_text_widget.dart';

class EditNote extends StatefulWidget {
  const EditNote({super.key});

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> with WidgetsBindingObserver {
  late Brightness _brightness;
  late ScrollController _scrollController;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _brightness == Brightness.light
          ? MyThemes.getThemeFromKey(MyThemeKeys.LIGHT).primaryColor
          : MyThemes.getThemeFromKey(MyThemeKeys.DARK).primaryColor,
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(
              height: 60,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Let's write in English.",
                  style: TextStyle(color: Colors.white, fontSize: 28),
                ),
                AppbarCloseButton(),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            SingleChildScrollView(
              controller: _scrollController,
              child: Column(
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
                    child: const EditText(
                      hintText: 'What is topic of your writing?',
                      labelText: 'Topic',
                      maxLines: 3,
                      gestureTapCallback: null,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    alignment: Alignment.topCenter,
                    height: 300,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: EditText(
                      hintText: 'Please write the content.',
                      labelText: 'Content',
                      maxLines: null,
                      gestureTapCallback: () {
                        _scrollController.animateTo(
                          100.0,
                          duration: const Duration(microseconds: 500),
                          curve: Curves.ease,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
