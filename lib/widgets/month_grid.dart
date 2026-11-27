import 'package:flutter/material.dart';
import '../utils/dates.dart';

class MonthGrid extends StatelessWidget {
  final DateTime? selectedDay;
  final DateTime month;
final void Function(DateTime) onDaySelected;

const MonthGrid({super.key, required this.selectedDay, required this.month, required this.onDaySelected});
  @override
  Widget build(BuildContext context) {
    DateTime firstDay = DateTime(month.year, month.month, 1);
    int daysInMonth = DateTime(month.year, month.month + 1, 0).day;
    int leadingBlanks = firstDay.weekday % 7;

    List<Widget> boxes = [];
    // weekday labels as the first row

    List<String> weekdays = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
    for (String name in weekdays) {
      boxes.add(Center(
        child: Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ));
    }
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
          backgroundColor: isSelected ? Colors.lightBlue.shade100 : null,
          side: isToday ? const BorderSide(color: Colors.lightBlue, width: 2) : null,
        ),
        onPressed: () => onDaySelected(thisDay),
        child: Text('$day'),
      )));
    }


  // https://api.flutter.dev/flutter/rendering/SliverGridDelegateWithFixedCrossAxisCount-class.html
    return GridView(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        mainAxisExtent: 40,
      ),
      shrinkWrap: true,
      children: boxes,
    );
  }
}