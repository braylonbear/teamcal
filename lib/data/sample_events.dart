import '../models/event.dart';

final List<Event> sampleEvents = [
  Event(
    id: '1',
    title: 'Practice',
    type: EventType.practice,
    status: EventStatus.scheduled,
    startTime: DateTime(2026, 11, 14, 15, 0),
    location: 'Fieldhouse',
  ),
  Event(
    id: '2',
    title: 'Game',
    type: EventType.game,
    status: EventStatus.cancelled,
    startTime: DateTime(2026, 11, 15, 19, 0),
    location: 'Stadium',
  ),
  Event(
    id: '3',
    title: 'Team Meeting',
    type: EventType.meeting,
    status: EventStatus.scheduled,
    startTime: DateTime(2026, 11, 16, 10, 0),
    location: 'Conference Room',
    updatedAt: DateTime(2026, 11, 13, 12, 0),
  ),
  Event(
    id: '4',
    title: 'Workout',
    type: EventType.lift,
    status: EventStatus.scheduled,
    startTime: DateTime(2026, 11, 17, 7, 0),
    location: 'Gym',
    notes: 'Bring water and a towel.',
  ),
  Event(
    id: '5',
    title: 'Social Event',
    type: EventType.other,
    status: EventStatus.scheduled,
    startTime: DateTime(2026, 11, 18, 18, 0),
    location: 'Restaurant',
  ),
];