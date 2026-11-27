import 'package:flutter/material.dart';
import '../models/event.dart';

// Popup form that returns a new Event on Add, or null on Cancel.
class AddEventDialog extends StatefulWidget {
  final DateTime day;

  const AddEventDialog({super.key, required this.day});

  @override
  State<AddEventDialog> createState() => _AddEventDialogState();
}

class _AddEventDialogState extends State<AddEventDialog> {
  String title = '';
  String location = '';
  String notes = '';
  EventType _type = EventType.practice;
  TimeOfDay _time = const TimeOfDay(hour: 15, minute: 0);

  Future<void> pickTime() async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _time,
    );

    if (picked != null) {
      setState(() {
        _time = picked;
      });
    }
  }

  void save() {
    String title = this.title.trim();

    if (title.isEmpty) {
      return;
    }

    DateTime start = DateTime(
      widget.day.year,
      widget.day.month,
      widget.day.day,
      _time.hour,
      _time.minute,
    );

    Event newEvent = Event(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      type: _type,
      status: EventStatus.scheduled,
      startTime: start,
      location: location.trim(),
      notes: notes.trim().isEmpty ? null : notes.trim(),
    );

    Navigator.pop(context, newEvent);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Event'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            decoration: const InputDecoration(labelText: 'Event Title'),
            onChanged: (value) => title = value,
          ),
          DropdownButton<EventType>(
            value: _type,
            isExpanded: true,
            items: [
              for (EventType t in EventType.values)
                DropdownMenuItem(value: t, child: Text(t.name)),
            ],
            onChanged: (value) {
              setState(() {
                _type = value!;
              });
            },
          ),
          Row(
            children: [
              Text('Time: ${_time.format(context)}'),
              const Spacer(),
              TextButton(
                onPressed: () => pickTime(),
                child: const Text('Change'),
              ),
            ],
          ),
          TextField(
            decoration: const InputDecoration(labelText: 'Location'),
            onChanged: (value) => location = value,
          ),
          TextField(
            decoration: const InputDecoration(labelText: 'Notes (optional)'),
            maxLines: 3,
            minLines: 1,
            onChanged: (value) => notes = value,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: save,
          child: const Text('Add'),
        ),
      ],
    );
  }
}