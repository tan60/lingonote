import 'package:flutter/material.dart';

class RoundedIconButton extends StatelessWidget {
  final IconData iconData;
  final Function()? onTap;
  final Color? enableColor;
  final bool isEnable;
  final bool isLoading;

  const RoundedIconButton({
    super.key,
    required this.iconData,
    required this.onTap,
    required this.isEnable,
    required this.isLoading,
    required this.enableColor,
  });

  void setLoading(bool isLoading) {
    isLoading = isLoading;
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
          child: isLoading
              ? SizedBox(
                  width: 32,
                  height: 32,
                  child: CircularProgressIndicator(
                    color: Colors.white.withOpacity(0.5),
                    strokeWidth: 4,
                  ),
                )
              : SizedBox(
                  width: 32,
                  height: 32,
                  child: Icon(
                    iconData,
                    color: isEnable
                        ? (enableColor ?? Colors.white)
                        : Colors.white.withOpacity(0.3),
                    size: 32,
                  ),
                ),
        ),
      ),
    );
  }
}
