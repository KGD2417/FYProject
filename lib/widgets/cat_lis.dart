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
    thumbnail: 'assets/images/events.png',
  ),
  Category(
    name: 'Bus Tracking',
    thumbnail: 'assets/images/bt.png',
  ),
  Category(
    name: 'Attendance',
    thumbnail: 'assets/images/attendance.png',
  ),
  Category(
    name: 'Certificates',
    thumbnail: 'assets/images/certificates.png',
  ),
  Category(
    name: 'Report Card',
    thumbnail: 'assets/images/report-card.png',
  ),
  Category(
    name: 'Quiz',
    thumbnail: 'assets/images/quiz.png',
  ),
];