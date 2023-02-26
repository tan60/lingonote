import 'package:flutter/material.dart';

class AppBarCloseButton extends StatelessWidget {
  const AppBarCloseButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(18),
      ),
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Tap'),
          ));
        },
        child: Container(
          //width: 50,
          //height: 50,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(10),
          child: const Icon(
            Icons.close_rounded,
            color: Colors.white,
            size: 32,
          ),
        ),
      ),
    );
  }
}
