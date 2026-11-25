// Returns true if both dates fall on the same calendar day.
// The time of day is ignored, so 3:00 PM and midnight on Nov 14 count as the same day.
bool isSameDay(DateTime a, DateTime b) {
  if (a.year != b.year) {
    return false;
  }
  if (a.month != b.month) {
    return false;
  }
  if (a.day != b.day) {
    return false;
  }
  return true;
}