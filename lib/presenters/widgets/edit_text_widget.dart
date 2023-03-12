import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class EditText extends StatelessWidget {
  final String labelText, hintText;
  final int? maxLines;
  final GestureTapCallback? gestureTapCallback;
  final TextEditingController? textEditingController;
  final Function(String string)? onChanged;

  const EditText({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.maxLines,
    required this.gestureTapCallback,
    required this.textEditingController,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    //RegExp denyExp = RegExp(r"[ㄱ-ㅎㅏ-ㅣ가-힣]");
    return TextField(
      controller: textEditingController,
      onTap: gestureTapCallback,
      style: TextStyle(
        color: Colors.white,
        fontSize: 16.sp,
      ),
      cursorColor: Colors.white,
      keyboardType: TextInputType.multiline,
      /*inputFormatters: [
        FilteringTextInputFormatter.deny(denyExp),
      ],*/
      minLines: 1,
      maxLines: maxLines,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white.withOpacity(0),
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white.withOpacity(0),
          ),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white.withOpacity(0),
          ),
        ),
      ),
    );
  }
}
