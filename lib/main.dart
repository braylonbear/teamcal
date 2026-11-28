import 'package:flutter/material.dart';
import 'data/sample_events.dart';
import 'widgets/event_tile.dart';
import 'widgets/month_grid.dart';
import 'widgets/add_event_dialog.dart';
import 'models/event.dart';

void main() => runApp(const TeamCalApp());

class TeamCalApp extends StatelessWidget {
  const TeamCalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // take off the debug banner
      debugShowCheckedModeBanner: false,
        theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 6, 40, 90)),
        appBarTheme: AppBarTheme(
          backgroundColor: const Color.fromARGB(255, 6, 40, 90),
          foregroundColor: Colors.white,
        ),
      ),
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
    DateTime shownMonth = DateTime(DateTime.now().year, DateTime.now().month, 1);
  final List<String> monthNames = const ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
  List<Event> events = List.of(sampleEvents);

  void prevMonth() {
    setState(() {
      shownMonth = DateTime(shownMonth.year, shownMonth.month - 1, 1);
      selectedDay = null;
    });
  }
  void nextMonth() {
    setState(() {
      shownMonth = DateTime(shownMonth.year, shownMonth.month + 1, 1);
      selectedDay = null;
    });
  }

  Future<void> addEventPressed() async {
      if (selectedDay == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tap a day first to add an event')),
      );
      return;
    }

    Event? newEvent = await showDialog<Event>(
      context: context,
      builder: (context) => AddEventDialog(day: selectedDay!),
    );

    if (newEvent != null) {
      setState(() {
        events.add(newEvent);
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    // Decide which events to show
    List<Event> visibleEvents = [];

    if (selectedDay == null) {
      // No day tapped, so show everything in the shown month
      for (Event event in events) {
        if (event.startTime.year == shownMonth.year && event.startTime.month == shownMonth.month) {
          visibleEvents.add(event);
        }
      }
    } else {
      // Only keep events on the selected day
      for (Event event in events) {
        if (isSameDay(event.startTime, selectedDay!)) {
          visibleEvents.add(event);
        }
      }
    }
    String listLabel;
    if (selectedDay == null) {
      listLabel = 'Events in ${monthNames[shownMonth.month - 1]}';
    } else {
      listLabel = 'Events on ${monthNames[selectedDay!.month - 1]} ${selectedDay!.day}';
    }

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.sports_baseball),
            SizedBox(width: 10),
            Text('DSU Baseball'),
          ],
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Text('TeamCal', style: TextStyle(fontSize: 18)),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addEventPressed,
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Row(                                   
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: prevMonth,
              ),
              Text(
                '${monthNames[shownMonth.month - 1]} ${shownMonth.year}',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: nextMonth,
              ),
            ],
          ),
          MonthGrid(
            selectedDay: selectedDay,
            month: shownMonth,
            events: events,
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                listLabel,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),
          Expanded(
                child: visibleEvents.isEmpty
                    ? Center(
                        child: Text(selectedDay == null
                            ? 'No events this month'
                            : 'No events on this day'),
                      )
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