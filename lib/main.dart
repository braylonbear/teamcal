import 'package:flutter/material.dart';
import 'data/sample_events.dart';
import 'widgets/event_tile.dart';
import 'widgets/month_grid.dart';
void main() => runApp(const TeamCalApp());

class TeamCalApp extends StatelessWidget {
  const TeamCalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // take off the debug banner
      debugShowCheckedModeBanner: false,
      home: const CalendarScreen(),     
    );
  }
}

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime? selectedDay;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('TeamCal')),
        body: Column(
          children: [
            MonthGrid(
              selectedDay: selectedDay,
              onDaySelected: (day) {
                setState(() {
                  selectedDay = day;
                });
              },
            ),
            const Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: sampleEvents.length,
                itemBuilder: (context, index) {
                  return EventTile(event: sampleEvents[index]);
                },
              ),
            ),
          ],
        ),
      );
    // here is the end of the Scaffold widget
  }
}