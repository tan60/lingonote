import 'package:flutter/material.dart';

class EditText extends StatelessWidget {
  final String labelText, hintText;
  final int? maxLines;
  final GestureTapCallback? gestureTapCallback;

  const EditText({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.maxLines,
    required this.gestureTapCallback,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: gestureTapCallback,
      style: const TextStyle(color: Colors.white, fontSize: 24),
      cursorColor: Colors.white,
      keyboardType: TextInputType.multiline,
      minLines: 1,
      maxLines: maxLines,
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
