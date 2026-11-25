import 'package:flutter/material.dart';

class MonthGrid extends StatelessWidget {
  final DateTime? selectedDay;
final void Function(DateTime) onDaySelected;

const MonthGrid({super.key, required this.selectedDay, required this.onDaySelected});
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
      bool isSelected = selectedDay != null &&
          selectedDay!.year == firstDay.year &&
          selectedDay!.month == firstDay.month &&
          selectedDay!.day == day;

      boxes.add(Center(child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: isSelected ? Colors.blue.shade100 : null,
        ),
        onPressed: () => onDaySelected(DateTime(firstDay.year, firstDay.month, day)),
        child: Text('$day'),
      )));
    }


    return GridView.count(
      crossAxisCount: 7,   // 7 days per row
      shrinkWrap: true,
      childAspectRatio: 3,
      children: boxes,
    );
  }
}