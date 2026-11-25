import 'package:flutter/material.dart';

class MonthGrid extends StatelessWidget {
  const MonthGrid({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime firstDay = DateTime(2026, 11, 1);
    int daysInMonth = 30;
    int leadingBlanks = firstDay.weekday % 7;

    List<Widget> boxes = [];

    // empty boxes first
    for (int i = 0; i < leadingBlanks; i++) {
      boxes.add(Text(''));
    }

    // then the day numbers
    for (int day = 1; day <= daysInMonth; day++) {
      boxes.add(Center(child: Text('$day')));
    }

    return GridView.count(
      crossAxisCount: 7,   // 7 days per row
      shrinkWrap: true,
      childAspectRatio: 3,
      children: boxes,
    );
  }
}