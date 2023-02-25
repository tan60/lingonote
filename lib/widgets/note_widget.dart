import 'package:flutter/material.dart';

class Note extends StatelessWidget {
  final title, contents, date;
  const Note({
    super.key,
    required this.title,
    required this.contents,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 25),
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 18,
              offset: const Offset(0, 12),
              color: Colors.black.withOpacity(0.2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              maxLines: 2,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.3,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              contents,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.3,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Container(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('A.I Improved'),
                Text(date),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
