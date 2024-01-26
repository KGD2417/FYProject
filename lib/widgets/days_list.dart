class DaysList {
  String name;
  String actualName;

  DaysList({
    required this.name,
    required this.actualName,
  });
}

List<DaysList> daysList = [
  DaysList(
    name: 'M',
    actualName: "Mon"
  ),

  DaysList(
    name: 'T',
      actualName: "Tue"
  ),

  DaysList(
    name: 'W',
      actualName: "Wed"
  ),

  DaysList(
    name: 'T',
      actualName: "Thu"
  ),

  DaysList(
    name: 'F',
      actualName: "Fri"
  ),

];