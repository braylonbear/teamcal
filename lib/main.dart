import 'package:flutter/material.dart';
import 'data/sample_events.dart';
import 'widgets/event_tile.dart';
import 'widgets/month_grid.dart';
import 'models/event.dart';
import 'utils/dates.dart';

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
    // Decide which events to show
    List<Event> visibleEvents = [];

    if (selectedDay == null) {
      // No day tapped yet, so show everything
      visibleEvents = sampleEvents;
    } else {
      // Only keep events on the selected day
      for (Event event in sampleEvents) {
        if (isSameDay(event.startTime, selectedDay!)) {
          visibleEvents.add(event);
        }
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('TeamCal')),
      body: Column(
        children: [
          MonthGrid(
            selectedDay: selectedDay,
            onDaySelected: (day) {
              setState(() {
                if (selectedDay != null && isSameDay(selectedDay!, day)) {
                  // Tapped the day that's already selected, so clear it
                  selectedDay = null;
                } else {
                  // Tapped a new day, so select it
                  selectedDay = day;
                }
              });
            },
          ),
          const Divider(),
          Expanded(
                child: visibleEvents.isEmpty
                    ? const Center(child: Text('No events on this day'))
                    : ListView.builder(
                itemCount: visibleEvents.length,
                itemBuilder: (context, index) {
                return EventTile(event: visibleEvents[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}