import 'package:flutter/material.dart';

class RoundedIconButton extends StatelessWidget {
  final IconData iconData;
  final Function()? onTap;
  bool isEnable;
  final Color? enableColor;

  RoundedIconButton({
    super.key,
    required this.iconData,
    required this.onTap,
    required this.isEnable,
    required this.enableColor,
  });

  void setEnable(bool enable) {
    isEnable = isEnable;
  }

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(18),
      ),
      child: InkWell(
        onTap: isEnable ? onTap : null,
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(10),
          child: Icon(
            iconData,
            color: isEnable
                ? (enableColor ?? Colors.white)
                : Colors.white.withOpacity(0.3),
            size: 32,
          ),
        ),
      ),
    );
  }
}
