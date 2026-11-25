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
      home: Scaffold(
        appBar: AppBar(title: const Text('TeamCal')),
        body: Column(
          children: [
            const MonthGrid(),
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
      ),
    );
  }
}