import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:vidyaniketan_app/screens/teach_assignpage.dart';

class ClassListPage extends StatelessWidget {
  final List<String> classes = ['Class1', 'Class2', 'Class3', 'Class4', 'Class5'];

  ClassListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Class List"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: classes.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ClassDetailPageState(className: classes[index]),
                ),
              );
            },
            child: Card(
              child: ListTile(
                title: Text(classes[index]),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ClassDetailPageState extends StatefulWidget {
  final String className;

  const ClassDetailPageState({Key? key, required this.className}) : super(key: key);

  @override
  _ClassDetailPageState createState() => _ClassDetailPageState();
}

class _ClassDetailPageState extends State<ClassDetailPageState> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.className),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('assign')
            .doc(widget.className)
            .collection('Subcollections')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('No subcollections found under ${widget.className}.'),
            );
          }

          return Scaffold(
            body: Container(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  var subcollectionName = snapshot.data!.docs[index].id;

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TeachAssignPage(
                            className: widget.className,
                            listName: subcollectionName,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      child: ListTile(
                        title: Text(subcollectionName),
                      ),
                    ),
                  );
                },
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                _showAssignmentDialog(context);
              },
              child: const Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }

  void _showAssignmentDialog(BuildContext context) async {
    List<XFile> images = [];

    final TextEditingController titleController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    final TextEditingController assignedDateController = TextEditingController();
    final TextEditingController dueDateController = TextEditingController();
    final TextEditingController subjectController = TextEditingController();

    final ImagePicker imagePicker = ImagePicker(); // Instantiate ImagePicker

    void _selectDate(TextEditingController controller) async {
      final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
      );
      if (pickedDate != null) {
        controller.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      }
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Create New Assignment'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(labelText: 'Assignment Title'),
                    ),
                    TextField(
                      controller: descriptionController,
                      decoration: const InputDecoration(labelText: 'Description'),
                    ),
                    TextField(
                      controller: assignedDateController,
                      decoration: const InputDecoration(labelText: 'Assigned Date'),
                      onTap: () {
                        _selectDate(assignedDateController);
                      },
                    ),
                    TextField(
                      controller: dueDateController,
                      decoration: const InputDecoration(labelText: 'Due Date'),
                      onTap: () {
                        _selectDate(dueDateController);
                      },
                    ),
                    TextField(
                      controller: subjectController,
                      decoration: const InputDecoration(labelText: 'Subject'),
                    ),
                    const SizedBox(height: 10),
                    // Button to select multiple images
                    ElevatedButton(
                      onPressed: () async {
                        List<XFile> resultList = [];
                        try {
                          final pickedImages = await imagePicker.pickMultiImage();
                          if (pickedImages != null) {
                            resultList.addAll(pickedImages);
                          }
                        } catch (e) {
                          if (kDebugMode) {
                            print('Error picking images: $e');
                          }
                        }
                        if (resultList.isNotEmpty) {
                          setState(() {
                            images = resultList;
                          });
                        }
                      },
                      child: const Text('Select Images'),
                    ),
                    // Display number of selected images
                    if (images.isNotEmpty)
                      Text('Selected Images: ${images.length}'),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    _submitAssignment(
                      titleController.text,
                      descriptionController.text,
                      assignedDateController.text,
                      dueDateController.text,
                      subjectController.text,
                      images,
                    );
                    Navigator.of(context).pop();
                  },
                  child: const Text('Submit'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _submitAssignment(String title, String description, String assignedDate,
      String dueDate, String subject, List<XFile> images) async {
    if (kDebugMode) {
      print('Submitting assignment with title: $title, description: $description, assignedDate: $assignedDate, dueDate: $dueDate, subject: $subject, images: $images');
    }
    Timestamp assignedTimestamp = Timestamp.fromDate(DateTime.parse(assignedDate));
    Timestamp dueTimestamp = Timestamp.fromDate(DateTime.parse(dueDate));

    await FirebaseFirestore.instance
        .collection('assign')
        .doc(widget.className)
        .collection(title)
        .doc('Info')
        .set({
      'AssignDate': assignedTimestamp,
      'DueDate': dueTimestamp,
      'Content': description,
      'Subject': subject,
    });
    if (kDebugMode) {
      print('Assignment info stored in Firestore.');
    }
    await FirebaseFirestore.instance
        .collection('assign')
        .doc(widget.className)
        .collection('Subcollections')
        .doc(title)
        .set({
      'title': title,
      'createdAt': FieldValue.serverTimestamp(),
    });

    if (images.isNotEmpty) {
      List<String> imageURLs = [];
      for (var imageFile in images) {
        String imageUrl = await _uploadImageToStorage(imageFile, title);
        if (imageUrl.isNotEmpty) {
          imageURLs.add(imageUrl);
        }
      }

      // Save image URLs to Firestore with auto-generated document ID
      await FirebaseFirestore.instance
          .collection('assign')
          .doc(widget.className)
          .collection(title)
          .doc('Info')
          .collection('images')
          .add({'imageUrl': imageURLs});
    }
    if (kDebugMode) {
      print('Assignment submitted successfully!');
    }
  }


  Future<String> _uploadImageToStorage(XFile imageFile, String title) async {
    try {
      Uint8List imageData = await imageFile.readAsBytes();

      String imageName = '${DateTime.now().millisecondsSinceEpoch}_${imageFile.name}';
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage.ref().child('assign/${widget.className}/$title/Info/images/$imageName');
      UploadTask uploadTask = ref.putData(imageData, SettableMetadata(contentType: 'image/jpeg'));
      TaskSnapshot taskSnapshot = await uploadTask;
      String imageUrl = await taskSnapshot.ref.getDownloadURL();
      if (kDebugMode) {
        print('Image uploaded successfully: $imageUrl');
      }
      return imageUrl;
    } catch (e) {
      if (kDebugMode) {
        print('Error uploading image: $e');
      }
      return '';
    }
  }


}