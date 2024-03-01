import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:intl/intl.dart';

import 'events_screen.dart';

class EventListPage extends StatefulWidget {
  const EventListPage({super.key});

  @override
  _EventListPageState createState() => _EventListPageState();
}

class _EventListPageState extends State<EventListPage> {
  late TextEditingController _eventNameController;
  late DateTime _selectedDate;
  File? _image;

  @override
  void initState() {
    super.initState();
    _eventNameController = TextEditingController();
    _selectedDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event List'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('event').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final List<DocumentSnapshot> events = snapshot.data!.docs;

          return ListView.builder(
            itemCount: events.length,
            itemBuilder: (context, index) {
              final event = events[index];
              final eventDate = (event['Date'] as Timestamp).toDate();
              final formattedDate = DateFormat.yMd().format(eventDate);
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16), // Add margin for padding
                decoration: const BoxDecoration(
                ),
                child: Material(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MediaGalleryScreen(eventName: event.id),
                        ),
                      );
                    },
                    child: ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(event.id),
                          Text(formattedDate),
                        ],
                      ),
                      leading: Container(
                        decoration: const BoxDecoration(
                          // border: Border.all(
                          //   color: Colors.black, // Set border color here
                          //   width: 2, // Set border width here
                          // ),
                          // borderRadius: BorderRadius.circular(30), // Set border radius here
                        ),
                        child: CircleAvatar(
                          radius: 28, // Adjust the radius to match the border width
                          backgroundImage: NetworkImage(event['imageUrl']),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddEventDialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }



  void _showAddEventDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Add Event'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _eventNameController,
                    decoration: const InputDecoration(
                      hintText: 'Enter Event Name',
                    ),
                  ),
                  const SizedBox(height: 10),
                  _image != null
                      ? Image.file(
                    _image!,
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  )
                      : ElevatedButton(
                    onPressed: () async {
                      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                      setState(() {
                        if (pickedFile != null) {
                          _image = File(pickedFile.path);
                        }
                      });
                    },
                    child: const Text('Select Image'),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () async {
                      final pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          _selectedDate = pickedDate;
                        });
                      }
                    },
                    child: Text(
                      'Selected Date: ${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}',
                    ),
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _addEventToDatabase(_eventNameController.text, _selectedDate, _image);
                    Navigator.of(context).pop();
                    _eventNameController.clear();
                    setState(() {
                      _image = null;
                    });
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


  void _addEventToDatabase(String eventName, DateTime selectedDate, File? image) async {
    try {
      DocumentReference eventRef = FirebaseFirestore.instance.collection('event').doc(eventName);
      if (!(await eventRef.get()).exists) {
        String imageUrl = '';

        // Upload image to Firebase Storage
        if (image != null) {
          imageUrl = await _uploadImageToStorage(image, eventName);
        }
        // Create document with event details
        await eventRef.set({
          'Date': selectedDate,
          'imageUrl': imageUrl,
        });
        CollectionReference imagesRef = eventRef.collection('images');
        await imagesRef.add({
          'imageUrl': imageUrl,
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error adding event: $e');
      }
      // Handle error
    }
  }

  Future<String> _uploadImageToStorage(File image, String eventName) async {
    try {
      String imageName = '${DateTime.now().millisecondsSinceEpoch}_${image.path.split('/').last}';
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage.ref().child('images/$eventName/$imageName');
      UploadTask uploadTask = ref.putFile(image);
      TaskSnapshot taskSnapshot = await uploadTask;
      String imageUrl = await taskSnapshot.ref.getDownloadURL();
      return imageUrl;
    } catch (e) {
      if (kDebugMode) {
        print('Error uploading image: $e');
      }
      // Handle error
      return ''; // Return empty string if uploading fails
    }
  }



  @override
  void dispose() {
    _eventNameController.dispose();
    super.dispose();
  }
}



