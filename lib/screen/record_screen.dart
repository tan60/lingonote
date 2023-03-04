import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class RecordScreen extends StatefulWidget {
  const RecordScreen({super.key});

  @override
  State<RecordScreen> createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  @override
  Widget build(BuildContext context) {
    return const CalendarUI();
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

    int weekday = weekDayMap[endDateWeekday]; //DateTime.now().weekday + 1;

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

    double weeksCount = (items.length + weekday) / 7;

    getDaysInBetween();

    int indexIgnoreCount = 0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
      child: SizedBox(
        height: 300,
        child: Row(
          children: [
            Container(
              constraints: const BoxConstraints(
                minHeight: 20,
              ),
              child: Column(
                // crossAxisAlignment: ,
                /* mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween, */
                children: [
                  const Spacer(flex: 1),
                  Text(
                    '',
                    style: TextStyle(
                        fontSize: 7.sp,
                        color: Theme.of(context).textTheme.displayLarge?.color),
                  ),
                  const Spacer(flex: 2),
                  Text(
                    'Sun',
                    style: TextStyle(
                        fontSize: 7.sp,
                        color: Theme.of(context).textTheme.displayLarge?.color),
                  ),
                  const Spacer(flex: 2),
                  Text(
                    'Mon',
                    style: TextStyle(
                        fontSize: 7.sp,
                        color: Theme.of(context).textTheme.displayLarge?.color),
                  ),
                  const Spacer(flex: 2),
                  Text(
                    'Tue',
                    style: TextStyle(
                        fontSize: 7.sp,
                        color: Theme.of(context).textTheme.displayLarge?.color),
                  ),
                  const Spacer(flex: 2),
                  Text(
                    'Wed',
                    style: TextStyle(
                        fontSize: 7.sp,
                        color: Theme.of(context).textTheme.displayLarge?.color),
                  ),
                  const Spacer(flex: 2),
                  Text(
                    'Thu',
                    style: TextStyle(
                        fontSize: 7.sp,
                        color: Theme.of(context).textTheme.displayLarge?.color),
                  ),
                  const Spacer(flex: 2),
                  Text(
                    'Fri',
                    style: TextStyle(
                        fontSize: 7.sp,
                        color: Theme.of(context).textTheme.displayLarge?.color),
                  ),
                  const Spacer(flex: 2),
                  Text(
                    'Sat',
                    style: TextStyle(
                        fontSize: 7.sp,
                        color: Theme.of(context).textTheme.displayLarge?.color),
                  ),
                  const Spacer(flex: 1),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    reverse: false,
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 8,
                    ),
                    itemCount: items.length + weekday + weeksCount.toInt(),
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

                          log('-------- key : $key');

                          for (int i = key; i < key + 7; i++) {
                            if (i >= weekday) {
                              log('${newList[i - weekday - indexIgnoreCount]}');
                            }

                            if (i >= weekday &&
                                newList[i - weekday - indexIgnoreCount].day ==
                                    1) {
                              log('isFirstDaty : ${newList[i - weekday - indexIgnoreCount]}');
                              month = newList[i - weekday - indexIgnoreCount]
                                  .month
                                  .toString();
                            }
                          }

                          return Container(
                            margin: const EdgeInsets.all(6),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .highlightColor
                                    .withOpacity(0),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5)),
                              ),
                              child: Center(
                                child: Text(
                                  month,
                                  style: TextStyle(
                                      fontSize: 7.sp,
                                      color: Theme.of(context)
                                          .textTheme
                                          .displayLarge
                                          ?.color),
                                ),
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

/* class CalendarUI extends StatelessWidget {
  const CalendarUI({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime nowDate = DateTime.now();
    DateTime startDate = DateTime(2022, 11, 01);

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

    int weekday = weekDayMap[endDateWeekday]; //DateTime.now().weekday + 1;

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

    double weeksCount = (items.length + weekday) / 7;

    getDaysInBetween();

    int indexIgnoreCount = 0;

    int totalCount = items.length + weekday + weeksCount.toInt();

    log('totalCount : $totalCount');

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
      child: Column(
        children: [
          Container(
            color: Colors.red,
            constraints: const BoxConstraints(
              minHeight: 50,
            ),
            child: Row(
              // crossAxisAlignment: ,
              /* mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween, */
              children: [
                const Spacer(flex: 1),
                Text(
                  'Year',
                  style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).textTheme.displayLarge?.color),
                ),
                const Spacer(flex: 2),
                Text(
                  'Sun',
                  style: TextStyle(
                      color: Theme.of(context).textTheme.displayLarge?.color),
                ),
                const Spacer(flex: 2),
                Text(
                  'Mon',
                  style: TextStyle(
                      color: Theme.of(context).textTheme.displayLarge?.color),
                ),
                const Spacer(flex: 2),
                Text(
                  'Tue',
                  style: TextStyle(
                      color: Theme.of(context).textTheme.displayLarge?.color),
                ),
                const Spacer(flex: 2),
                Text(
                  'Wed',
                  style: TextStyle(
                      color: Theme.of(context).textTheme.displayLarge?.color),
                ),
                const Spacer(flex: 2),
                Text(
                  'Thu',
                  style: TextStyle(
                      color: Theme.of(context).textTheme.displayLarge?.color),
                ),
                const Spacer(flex: 2),
                Text(
                  'Fri',
                  style: TextStyle(
                      color: Theme.of(context).textTheme.displayLarge?.color),
                ),
                const Spacer(flex: 2),
                Text(
                  'Sat',
                  style: TextStyle(
                      color: Theme.of(context).textTheme.displayLarge?.color),
                ),
                const Spacer(flex: 1),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: GridView.builder(
                  scrollDirection: Axis.vertical,
                  reverse: true,
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 8,
                  ),
                  itemCount: items.length + weekday + weeksCount.toInt(),
                  itemBuilder: (BuildContext context, int key) {
                    log('key : $key');
                    if (key < weekday + 1 || key % 8 == 0) {
                      if (key > 0 && key % 8 == 0) {
                        indexIgnoreCount++;
                        log('igrnore + 1 : $indexIgnoreCount');
                      } else if (key == 0) {
                        indexIgnoreCount = 0;
                        log('igrnore init : $indexIgnoreCount');
                      }
                      return Card(
                        margin: const EdgeInsets.all(6),
                        color: Theme.of(context).highlightColor,
                      );
                    } else {
                      int index = key - weekday - 1;
                      log('key : $key');
                      log('weekday : $weekday');
                      log('index : $index');
                      log('indexIgnoreCount : $indexIgnoreCount');
                      log('totalCount : $totalCount');
                      int newIndex = index - indexIgnoreCount;
                      if (newIndex < 0) {
                        newIndex = 0;
                      }
                      return Card(
                        margin: const EdgeInsets.all(6),
                        //color: Theme.of(context).primaryColor.withOpacity(0.7),
                        child: Container(
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).primaryColor.withOpacity(0.6),
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
    );
  }
} */
