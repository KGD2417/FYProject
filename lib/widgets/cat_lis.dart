class Category {
  String thumbnail;
  String name;

  Category({
    required this.name,
    required this.thumbnail,
  });
}

List<Category> categoryList = [
  Category(
    name: 'Assignments',
    thumbnail: 'assets/images/assignment.png',
  ),
  Category(
    name: 'Events',
    thumbnail: 'assets/images/lecture.png',
  ),
  Category(
    name: 'Bus Tracking',
    thumbnail: 'assets/images/bt.png',
  ),
  Category(
    name: 'Attendance',
    thumbnail: 'assets/images/growth.png',
  ),
  Category(
    name: 'Timetable',
    thumbnail: 'assets/images/timetable.png',
  ),
  Category(
    name: 'Certificates',
    thumbnail: 'assets/images/certificates.png',
  ),
  Category(
    name: 'Report Card',
    thumbnail: 'assets/images/timetable.png',
  ),
];