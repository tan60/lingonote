import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lingonote/managers/string_mgr.dart';
import 'package:sizer/sizer.dart';

class RecordScreen extends StatefulWidget {
  const RecordScreen({super.key});

  @override
  State<RecordScreen> createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 80,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        StringMgr().your,
                        style: TextStyle(
                            fontSize: 24.sp,
                            color: Theme.of(context)
                                .textTheme
                                .displayLarge
                                ?.color),
                      ),
                      Text(
                        StringMgr().archivement,
                        style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context)
                                .textTheme
                                .displayLarge
                                ?.color),
                      ),
                    ],
                  ),
                ),
                Ink(
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                      child: const SizedBox(
                        width: 32,
                        height: 32,
                        child: Icon(
                          Icons.settings_rounded,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 30,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
              child: Container(
                alignment: Alignment.bottomCenter,
                child: Text(
                  '"20일 동안 총 15개의 영문을 작성했습니다."',
                  style: TextStyle(
                      fontSize: 20.sp,
                      color: Theme.of(context).textTheme.displayLarge?.color),
                ),
              ),
            ),
          ),
          const Expanded(
            flex: 70,
            child: CalendarUI(),
          ),
        ],
      ),
    );
  }
}

class CalendarUI extends StatelessWidget {
  const CalendarUI({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime nowDate = DateTime.now();
    DateTime startDate = DateTime(2022, 12, 01);

    String endDateWeekday = DateFormat('EEEE').format(startDate);

    Map weekDayMap = {
      'Sunday': 0,
      'Monday': 1,
      'Tuesday': 2,
      'Wednesday': 3,
      'Thursday': 4,
      'Friday': 5,
      'Saturday': 6,
    };

    Map monthMap = {
      1: 'Jan',
      2: 'Feb',
      3: 'Mar',
      4: 'Apr',
      5: 'May',
      6: 'Jun',
      7: 'Jul',
      8: 'Aug',
      9: 'Sep',
      10: 'Oct',
      11: 'Nov',
      12: 'Dec',
    };

    int weekday = weekDayMap[endDateWeekday];

    getDaysInBetween() {
      final int difference =
          nowDate.difference(startDate).inDays + 1; //couting today
      return difference;
    }

    final items = List<DateTime>.generate(getDaysInBetween(), (i) {
      DateTime date = startDate;

      return date.add(Duration(days: i));
    });

    var newList = items.toList();

    int weeksCount = ((items.length + weekday) / 7).ceil();

    getDaysInBetween();

    int indexIgnoreCount = 0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 60),
      child: SizedBox(
        height: 300,
        child: Row(
          children: [
            Container(
              constraints: const BoxConstraints(
                minHeight: 20,
              ),
              child: Column(
                children: const [
                  Spacer(flex: 1),
                  WeekdayTextWidget(weekday: ''),
                  Spacer(flex: 2),
                  WeekdayTextWidget(weekday: 'Sun'),
                  Spacer(flex: 2),
                  WeekdayTextWidget(weekday: 'Mon'),
                  Spacer(flex: 2),
                  WeekdayTextWidget(weekday: 'Tue'),
                  Spacer(flex: 2),
                  WeekdayTextWidget(weekday: 'Wed'),
                  Spacer(flex: 2),
                  WeekdayTextWidget(weekday: 'Thu'),
                  Spacer(flex: 2),
                  WeekdayTextWidget(weekday: 'Fri'),
                  Spacer(flex: 2),
                  WeekdayTextWidget(weekday: 'Sat'),
                  Spacer(flex: 1),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                reverse: true,
                scrollDirection: Axis.horizontal,
                child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 8,
                    ),
                    itemCount: items.length + weekday + weeksCount,
                    itemBuilder: (BuildContext context, int key) {
                      int index = key - weekday - 1;
                      int newIndex = index - indexIgnoreCount;

                      if (key < weekday + 1 || key % 8 == 0) {
                        if (key % 8 == 0) {
                          if (key == 0) {
                            newIndex = 0;
                          } else if (key > 0) {
                            indexIgnoreCount++;
                          }

                          //key ~ key + 7
                          //check frist day of a week
                          String month = '';

                          try {
                            for (int i = key; i < key + 7; i++) {
                              int checkIndex = i - weekday - indexIgnoreCount;

                              if (checkIndex < newList.length) {
                                if (i >= weekday &&
                                    newList[i - weekday - indexIgnoreCount]
                                            .day ==
                                        1) {
                                  month = monthMap[
                                      newList[i - weekday - indexIgnoreCount]
                                          .month];
                                }
                              }
                            }
                          } catch (e) {
                            log('$e');
                          }

                          return Container(
                            margin: const EdgeInsets.all(6),
                            child: Container(
                              alignment: Alignment.bottomCenter,
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .highlightColor
                                    .withOpacity(0),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5)),
                              ),
                              child: Text(
                                month,
                                style: TextStyle(
                                    fontSize: 7.sp,
                                    fontWeight: FontWeight.w800,
                                    color: Theme.of(context)
                                        .textTheme
                                        .displayLarge
                                        ?.color),
                              ),
                            ),
                          );
                        } else if (key == 0) {
                          indexIgnoreCount = 0;
                        }

                        return Card(
                          margin: const EdgeInsets.all(6),
                          color:
                              Theme.of(context).highlightColor.withOpacity(0.3),
                        );
                      } else {
                        return Card(
                          margin: const EdgeInsets.all(6),
                          //color: Theme.of(context).primaryColor.withOpacity(0.7),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.6),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5)),
                            ),
                            child: Center(
                              child: Text(
                                  '${newList[newIndex].month}/${newList[newIndex].day}'),
                            ),
                          ),
                        );
                      }
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WeekdayTextWidget extends StatelessWidget {
  final String weekday;
  const WeekdayTextWidget({
    super.key,
    required this.weekday,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      weekday,
      style: TextStyle(
          fontSize: 7.sp,
          fontWeight: FontWeight.w800,
          color: Theme.of(context).textTheme.displayLarge?.color),
    );
  }
}
