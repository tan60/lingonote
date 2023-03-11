import 'package:flutter/material.dart';
import 'package:lingonote/domains/managers/string_mgr.dart';
import 'package:sizer/sizer.dart';

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
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.2,
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
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.2,
                color: Theme.of(context)
                    .textTheme
                    .displayLarge
                    ?.color
                    ?.withOpacity(0.7),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                improvedType != 'test'
                    ? Text(
                        StringMgr().correctedByAI,
                        style: TextStyle(
                            fontSize: 10.sp,
                            color: Theme.of(context).primaryColorDark),
                      )
                    : const Text(''),
                Text(
                  date,
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: Theme.of(context)
                        .textTheme
                        .displayLarge
                        ?.color
                        ?.withOpacity(0.5),
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
