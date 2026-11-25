import 'package:flutter/material.dart';
import '../utils/dates.dart';

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
      DateTime thisDay = DateTime(firstDay.year, firstDay.month, day);

      bool isSelected = selectedDay != null && isSameDay(selectedDay!, thisDay);
      bool isToday = isSameDay(DateTime.now(), thisDay);

      boxes.add(Center(child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: isSelected ? Colors.blue.shade100 : null,
          side: isToday ? const BorderSide(color: Colors.blue, width: 2) : null,
        ),
        onPressed: () => onDaySelected(thisDay),
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