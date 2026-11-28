import 'package:flutter/material.dart';
import '../models/event.dart';

class MonthGrid extends StatelessWidget {
  final DateTime? selectedDay;
  final DateTime month;
  final List<Event> events;
  final void Function(DateTime) onDaySelected;

  const MonthGrid({
    super.key,
    required this.selectedDay,
    required this.month,
    required this.events,
    required this.onDaySelected,
  });

  @override
  Widget build(BuildContext context) {
    DateTime firstDay = DateTime(month.year, month.month, 1);
    int daysInMonth = DateTime(month.year, month.month + 1, 0).day;
    // weekday doc: https://api.dart.dev/dart-core/DateTime/weekday.html
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

    // empty boxes before the 1st
    for (int i = 0; i < leadingBlanks; i++) {
      boxes.add(const Text(''));
    }

    // the day numbers
    for (int day = 1; day <= daysInMonth; day++) {
      DateTime thisDay = DateTime(firstDay.year, firstDay.month, day);

      bool isSelected = selectedDay != null && isSameDay(selectedDay!, thisDay);
      bool isToday = isSameDay(DateTime.now(), thisDay);

      bool hasEvent = false;
      for (Event event in events) {
        if (isSameDay(event.startTime, thisDay)) {
          hasEvent = true;
        }
      }

      boxes.add(Center(
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: isSelected ? Colors.blue.shade100 : null,
            side: isToday ? const BorderSide(color: Colors.blue, width: 2) : null,
          ),
          onPressed: () => onDaySelected(thisDay),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('$day'),
              if (hasEvent)
                Container(
                  width: 5,
                  height: 5,
                  decoration: const BoxDecoration(
                    color: Colors.lightBlue,
                    shape: BoxShape.circle,
                  ),
                ),
            ],
          ),
        ),
      ));
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