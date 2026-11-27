import 'package:flutter/material.dart';
import '../models/event.dart';


// StatelessWidget is flutters ui class
// final is like readonly
// super.key takes the argument and passes it straight up to the parent constructor
class EventTile extends StatelessWidget {
  final Event event;
  const EventTile({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
      return ListTile(
    leading: Icon(_iconFor(event.type)),
    title: Text(
      event.title,
      style: TextStyle(
        // if event status is cancelled
        decoration: event.status == EventStatus.cancelled
            ? TextDecoration.lineThrough
            : TextDecoration.none,
        color: event.status == EventStatus.cancelled ? Colors.grey : null,
      ),
    ),
    subtitle: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('${_formatTime(event.startTime)} · ${event.location}'),
        if (event.notes != null) Text(event.notes!),
      ],
    ),
    trailing: event.updatedAt != null
        ? const Chip(label: Text('Updated'))
        : null,
    );
  }

  IconData _iconFor(EventType type) => switch (type) {
    EventType.practice => Icons.sports_baseball,
    EventType.game => Icons.stadium,
    EventType.meeting => Icons.meeting_room,
    EventType.lift => Icons.fitness_center,
    EventType.other => Icons.event,
  };

  String _formatTime(DateTime d) {
    final period = d.hour < 12 ? 'AM' : 'PM';
    final hour = d.hour % 12 == 0 ? 12 : d.hour % 12;
    final minute = d.minute.toString().padLeft(2, '0');
    return '${d.month}/${d.day} · $hour:$minute $period';
  }
}
