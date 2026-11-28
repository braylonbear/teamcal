Created by: Braylon Bear
Class: Programming Languages, Fall 2026

# TeamCal
TeamCal is a calendar app I made for a sports team to keep track of practices, games, meetings, and lifts. I wrote it in Dart using Flutter and it runs as a web app, so you can open it on a computer or your phone.

## Links
Live app: https://braylonbear.github.io/teamcal/
GitHub repo: https://github.com/braylonbear/teamcal

## Features
- Arrows to go to the next or previous month, and the year changes when you go past December or January
- Today's date has a ring around it
- Days that have events have a small dot under them
- Tap a day to only see the events on that day, tap it again to see the whole month
- Each event shows an icon for its type, the time, the location, and notes if it has any
- Events that were changed show an "Updated" tag (right now this is shown with the sample data, editing is not built yet)
- You can add your own events with a title, type, time, location, and notes

## Required Software
- Flutter SDK, I used version 3.47.5 (this comes with Dart 3.13.4)
- Google Chrome to run it
- Git to download the project
- VS Code with the Flutter extension (not required, but it is what I used)

The app only uses the packages that come with Flutter, so there is nothing extra to install.

## How to Run

The easiest way is to open the live app: https://braylonbear.github.io/teamcal/

To run it from the code:

git clone https://github.com/braylonbear/teamcal.git
cd teamcal
flutter pub get
flutter run -d chrome

This downloads the project, moves into its folder, gets the packages it needs, and starts it in Chrome.

## Project Structure

lib/
  - main.dart                      
  main calendar screen
  - models/event.dart              
  the event type and status enums, and isSameDay
  - data/sample_events.dart        
  the sample events for November and December 2026
  - widgets/month_grid.dart        
  the calendar grid
  - widgets/event_tile.dart        
  how each event looks in the list
  - widgets/add_event_dialog.dart  
  the pop up for adding an event
docs/                            
the built web version that GitHub Pages uses

## Testing

I tested the app by hand using 10 test cases. They go through starting the app, picking and unpicking days, days with no events, changing months, adding events, and what happens when you refresh. The test cases and what should happen for each one are in the test cases document I turned in (Test_Cases_(TeamCal).docx).

## Limitations

- There is no database, so any events you add go away when you refresh the page. Only the sample events stay.
- There are no logins, so the coach and player roles I planned are not in yet.
- You can add events but you cannot edit or delete them yet. Because of that, the "Updated" tag only shows up on the sample events that were set up with it.

I plan to keep working on these during winter break, starting with editing and saving events, because I think TeamCal could be useful for the DSU baseball program.