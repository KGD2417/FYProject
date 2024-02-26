import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'events_screen.dart';

class StudEventListPage extends StatefulWidget {
  const StudEventListPage({super.key});

  @override
  _StudEventListPageState createState() => _StudEventListPageState();
}

class _StudEventListPageState extends State<StudEventListPage> {

  @override
  void initState() {
    super.initState();
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
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MediaGalleryScreen(eventName: event.id),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16), // Add margin for padding
                  decoration: const BoxDecoration(
                    // border: Border.all(
                    //   color: Colors.black, // Set border color here
                    //   width: 2, // Set border width here
                    // ),
                    // borderRadius: BorderRadius.circular(8), // Set border radius here
                  ),
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
              );
            },
          );
        },
      ),
    );
  }
  @override
  void dispose() {
    super.dispose();
  }
}



