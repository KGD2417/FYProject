import 'package:intl/intl.dart';

class DaysList {
  String name;
  String actualName;
  bool currentDay;

  DaysList({
    required this.name,
    required this.actualName,
    required this.currentDay
  });

}

List<DaysList> daysList = [
  DaysList(
    name: 'M',
    actualName: "Mon",
    currentDay: DateFormat('EEE').format(DateTime.now()) == "Mon"? true : false
  ),

  DaysList(
      name: 'T',
      actualName: "Tue",
      currentDay: DateFormat('EEE').format(DateTime.now()) == "Tue"? true : false
  ),

  DaysList(
      name: 'W',
      actualName: "Wed",
      currentDay: DateFormat('EEE').format(DateTime.now()) == "Wed"? true : false
  ),

  DaysList(
      name: 'T',
      actualName: "Thu",
      currentDay: DateFormat('EEE').format(DateTime.now()) == "Thu"? true : false
  ),

  DaysList(
    name: 'F',
      actualName: "Fri",
      currentDay: DateFormat('EEE').format(DateTime.now()) == "Fri"? true : false
  ),

];