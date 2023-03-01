import 'package:flutter/material.dart';
import 'package:lingonote/managers/string_mgr.dart';

class Note extends StatelessWidget {
  final String title, contents, date, improvedType;
  const Note(
      {super.key,
      required this.title,
      required this.contents,
      required this.date,
      required this.improvedType});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 25),
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Theme.of(context).cardColor,
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
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.3,
                color: Theme.of(context).textTheme.displayLarge?.color,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              contents,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.3,
                color: Theme.of(context).textTheme.displayLarge?.color,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                improvedType != 'none'
                    ? Text(
                        StringMgr().correctedByAI,
                        style: TextStyle(
                            color: Theme.of(context).primaryColorDark),
                      )
                    : const Text(''),
                Text(
                  date,
                  style: TextStyle(
                    color: Theme.of(context).textTheme.displayLarge?.color,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
