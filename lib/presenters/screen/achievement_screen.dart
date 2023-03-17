import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lingonote/domains/entities/achieve_entity.dart';
import 'package:lingonote/domains/managers/string_mgr.dart';
import 'package:lingonote/domains/usecases/achieve_usecase.dart';
import 'package:lingonote/presenters/screen/setting_screen.dart';
import 'package:sizer/sizer.dart';

class AchievementScreen extends StatefulWidget {
  const AchievementScreen({super.key});

  @override
  State<AchievementScreen> createState() => _AchievementScreen();
}

class _AchievementScreen extends State<AchievementScreen> {
  Future<int> totalCount = AchieveUsecase().fetchTotalPostedCount();
  Future<int> totalDays = AchieveUsecase().fetchTotalDays();
  Future<List<AchieveEntity>>? achieves = AchieveUsecase().fetchAchieve();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 70,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        StringMgr().your,
                        style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w200,
                            color: Theme.of(context)
                                .textTheme
                                .displayLarge
                                ?.color),
                      ),
                      Text(
                        StringMgr().accomplishments,
                        style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w400,
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
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SettingScreen(),
                          fullscreenDialog: true,
                          allowSnapshotting: true,
                        ),
                      );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      child: SizedBox(
                        width: 32,
                        height: 32,
                        child: Icon(
                          Icons.settings_rounded,
                          color: Theme.of(context).focusColor,
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
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Container(
                alignment: Alignment.bottomCenter,
                child: FutureBuilder(
                  future: totalCount,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      int totalCount = snapshot.data!;

                      return FutureBuilder(
                        future: totalDays,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(
                              '"${snapshot.data}일간 총 $totalCount개의 영문을 작성했습니다."',
                              style: TextStyle(
                                  fontSize: 20.sp,
                                  color: Theme.of(context)
                                      .textTheme
                                      .displayLarge
                                      ?.color),
                            );
                          } else {
                            return const EncourageWidget();
                          }
                        },
                      );
                    }

                    return const EncourageWidget();
                  },
                ),
              ),
            ),
          ),
          Expanded(
            flex: 70,
            child: FutureBuilder(
              future: achieves,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  log(snapshot.data!.toString());
                }

                return CalendarUI(achieves: snapshot.data);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class EncourageWidget extends StatelessWidget {
  const EncourageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Icon(
          Icons.auto_graph,
          size: 80,
          color: Theme.of(context).hintColor,
        ),
        const SizedBox(
          height: 24,
        ),
        Text(
          StringMgr().encourage,
          style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w300,
              color: Theme.of(context).textTheme.displayLarge?.color),
        ),
      ],
    );
  }
}

class CalendarUI extends StatelessWidget {
  final List<AchieveEntity>? achieves;
  const CalendarUI({
    super.key,
    required this.achieves,
  });

  @override
  Widget build(BuildContext context) {
    DateTime nowDate = DateTime.now();
    DateTime startDate = DateTime(2023, 01, 01);

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
                              child: MonthlyTextWidget(month: month),
                            ),
                          );
                        } else if (key == 0) {
                          indexIgnoreCount = 0;
                        }

                        return Card(
                          margin: const EdgeInsets.all(6),
                          elevation: 0,
                          color:
                              Theme.of(context).highlightColor.withOpacity(0.3),
                        );
                      } else {
                        return Builder(builder: (context) {
                          DateTime dateTime = newList[newIndex];

                          String dateTimeString =
                              DateFormat('yyyy-MM-dd').format(dateTime);

                          int postedCount = 0;

                          if (achieves != null) {
                            for (int i = 0; i < achieves!.length; i++) {
                              if (achieves![i].date == dateTimeString) {
                                postedCount = achieves![i].postedCount;
                                break;
                              }
                            }
                          }

                          double opacity = 0.3 * postedCount;
                          Color color;
                          if (opacity > 0) {
                            color = Theme.of(context)
                                .primaryColor
                                .withOpacity(opacity);
                          } else {
                            color = Theme.of(context).highlightColor;
                          }

                          return Card(
                            margin: const EdgeInsets.all(4),
                            elevation: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                color: color,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(6)),
                              ),
                            ),
                          );
                        });
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

class MonthlyTextWidget extends StatelessWidget {
  const MonthlyTextWidget({
    super.key,
    required this.month,
  });

  final String month;

  @override
  Widget build(BuildContext context) {
    return Text(
      month,
      style: TextStyle(
          fontSize: 7.sp,
          fontWeight: FontWeight.w800,
          color: Theme.of(context).textTheme.displayLarge?.color),
    );
  }
}

class WeekdayTextWidget extends StatelessWidget {
  const WeekdayTextWidget({
    super.key,
    required this.weekday,
  });

  final String weekday;

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
