// This is my first file that I am creating. It is very C# backboned, which I found is very close to 
// the dart programming language. The biggest differnce that I found out through google was the UI differences.
// I enjoy making UI so I am excieted to get to use the new tools that dart has to offer


//these enums represent the type and status of an event in the application
enum EventType { practice, game, meeting, lift, other }
enum EventStatus { scheduled, completed, cancelled }

// This class is the start and foundation of the calendar
// It contains all the necessary information for an event, such as its title, type, status, 
//start time, location, and optional notes. If I need to add more things I can come back later and do so
class Event
{
  String id;
  String title;
  EventType type;
  EventStatus status;
  DateTime startTime;
  String location;
  String? notes; // the ? means that it can be null
  DateTime? updatedAt;

  Event
  ({
    required this.id,
    required this.title,
    required this.type,
    required this.status,
    required this.startTime,
    required this.location,
    this.notes,
    this.updatedAt,
  });

  // now I am going to make actions for events

  void edit()
  {
    // TODO: Implement edit functionality for the event
  }

  void cancel()
  {
    // TODO: Implement cancel functionality for the event
  }


}