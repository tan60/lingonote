import 'package:flutter/material.dart';

class FeedHomeScreen extends StatefulWidget {
  final String screenName;
  const FeedHomeScreen({
    super.key,
    required this.screenName,
  });

  @override
  State<FeedHomeScreen> createState() =>
      _FeedHomeScreenState(screenName: screenName);
}

class _FeedHomeScreenState extends State<FeedHomeScreen> {
  final String screenName;

  _FeedHomeScreenState({required this.screenName});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: const Text('Feed'),
    );
  }
}
