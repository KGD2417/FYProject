class Category {
  String thumbnail;
  String name;
  int noOfCourses;

  Category({
    required this.name,
    required this.noOfCourses,
    required this.thumbnail,
  });
}

List<Category> categoryList = [
  Category(
    name: 'Assignments',
    noOfCourses: 55,
    thumbnail: 'assets/images/Assignment.png',
  ),
  Category(
    name: 'Lectures',
    noOfCourses: 20,
    thumbnail: 'assets/images/lecture.png',
  ),
  Category(
    name: 'Bus Tracking',
    noOfCourses: 16,
    thumbnail: 'assets/images/navi.png',
  ),
  Category(
    name: 'Analysis',
    noOfCourses: 25,
    thumbnail: 'assets/images/growth.png',
  ),
];