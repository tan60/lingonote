import 'package:flutter/material.dart';
import 'package:lingonote/presenters/widgets/rounded_icon_button_widget.dart';
import 'package:sizer/sizer.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 82,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Settings',
              style: TextStyle(
                fontSize: 18.sp,
                color: Theme.of(context).textTheme.displayLarge!.color,
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
              enableColor: Theme.of(context).textTheme.displayLarge!.color,
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
      body: Column(
        children: [
          SizedBox(
            height: 80,
            child: Row(
              children: const [
                Text('Color Theme'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


/***
 * 메뉴 언어 설정
 * - 한글
 * - 영어
 * 컬러 테마 설정
 * - 시스템 밝기
 * - 라이트 모드
 * - 다크 모드
 * 연락
 * - 평가하기
 * - 개발자에게 문의하기
 * 
 */
