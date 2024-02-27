import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:intl/intl.dart';
import 'package:vidyaniketan_app/screens/teach_list_name_page.dart';


class TeachAssignPage extends StatelessWidget {
  final String listName;
  final String className;
  const TeachAssignPage({Key? key, required this.listName, required this.className}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeWork'),
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            const TabBar(
              tabs: [
                Tab(text: 'Assignment'),
                Tab(text: 'Answers'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  AssignmentTabContent(listName: listName, className: className),
                  AnswersTabContent(listName: listName, className: className),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AssignmentTabContent extends StatelessWidget {
  final String listName;
  final String className;

  const AssignmentTabContent(
      {Key? key, required this.listName, required this.className})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // child: Text('Assignment Tab Content\nList Name: $listName\nClass Name: $className'),
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assignment'),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('assign')
            .doc(className)
            .collection(listName)
            .doc('Info')
            .snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData || snapshot.data!.data() == null) {
            return Center(
              child: Text('No data found for $listName.'),
            );
          }

          var data = snapshot.data!.data() as Map<String, dynamic>;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              // Adjust spacing between top and first ListTile
              Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 8.0, horizontal: 16.0),
                child: Row(
                  children: [
                    Text('Assignment Title: $listName'),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 8.0, horizontal: 16.0),
                child: Row(
                  children: [
                    Text('Description: ${data['Content'] ?? ''}'),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 8.0, horizontal: 16.0),
                child: Row(
                  children: [
                    Text('Subject: ${data['Subject'] ?? ''}'),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 8.0, horizontal: 16.0),
                child: Row(
                  children: [
                    Text('Assigned Date: ${_formatDate(data['AssignDate'])}'),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 8.0, horizontal: 16.0),
                child: Row(
                  children: [
                    Text('Due Date: ${_formatDate(data['DueDate'])}'),
                  ],
                ),
              ),
              const SizedBox(height: 8.0),
              // Adjust spacing between last item and next widget
              Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 0.0, horizontal: 16.0),
                child: const Row(
                  children: [
                    Text('Images for reference: '),
                  ],
                ),
              ),
              const SizedBox(height: 8.0),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('assign')
                      .doc(className)
                      .collection(listName)
                      .doc('Info')
                      .collection('images')
                      .snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Text('No images available');
                    }

                    List<String> imageUrls = [];
                    for (var doc in snapshot.data!.docs) {
                      var data = doc.data() as Map<String, dynamic>?; // Cast to Map<String, dynamic>
                      if (data != null && data.containsKey('imageUrl')) {
                        var imageUrl = data['imageUrl'];
                        if (imageUrl is String) {
                          imageUrls.add(imageUrl);
                        } else if (imageUrl is List) {
                          // If imageUrl is a List, add each element to the list
                          imageUrls.addAll(imageUrl.cast<String>());
                        }
                      }
                    }

                    return Column(
                      children: [
                        // Adjust spacing above GridView
                        const SizedBox(height: 8),
                        MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          child: _buildImagesGridView(imageUrls),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
  String _formatDate(dynamic date) {
    if (date is Timestamp) {
      DateTime dateTime = date.toDate();
      return DateFormat('MMMM d, y').format(dateTime);
    } else if (date is String) {
      return date;
    } else {
      return '';
    }
  }

  Widget _buildImagesGridView(List<String> imageUrls) {
    if (imageUrls.isEmpty) {
      return const Center(
        child: Text('No images available'),
      );
    } else {
      return GridView.builder(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
          childAspectRatio: 1.0,
        ),
        itemCount: imageUrls.length,
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(8.0), // Curved corners for images
            child: GestureDetector(
              onTap: () => _showImageGallery(context, imageUrls, index),
              child: Image.network(
                imageUrls[index],
                fit: BoxFit.cover,
              ),
            ),
          );
        },
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      );
    }
  }


  void _showImageGallery(BuildContext context, List<String> imageUrls, int initialIndex) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(),
          body: PhotoViewGallery.builder(
            itemCount: imageUrls.length,
            builder: (context, index) {
              return PhotoViewGalleryPageOptions(
                imageProvider: NetworkImage(imageUrls[index]),
                initialScale: PhotoViewComputedScale.contained,
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.covered * 2,
              );
            },
            scrollPhysics: const BouncingScrollPhysics(),
            loadingBuilder: (context, event) => const Center(
              child: CircularProgressIndicator(),
            ),
            backgroundDecoration: const BoxDecoration(color: Colors.black),
            pageController: PageController(initialPage: initialIndex),
          ),
        ),
      ),
    );
  }
}

class AnswersTabContent extends StatelessWidget {
  final String listName;
  final String className;

  const AnswersTabContent({Key? key, required this.listName, required this.className}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('assign')
          .doc(className)
          .collection(listName)
          .doc('Info')
          .collection('SubmittedStudents')
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text('No submitted students found.'),
          );
        }

        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (BuildContext context, int index) {
            var studentDocumentId = snapshot.data!.docs[index].id;
            // var studentPhotoUrl = studentData['photoUrl'] ?? '';

            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ListNamePage(
                      listName: listName,
                      className: className,
                      studentDocumentId: studentDocumentId,
                    ),
                  ),
                );
              },
              child: ListTile(
                leading: const CircleAvatar(
                  // backgroundImage: NetworkImage(studentPhotoUrl),
                ),
                title: Text(studentDocumentId), // Use document ID as list item name
              ),
            );
          },
        );
      },
    );
  }
}






// class AssignPage extends StatelessWidget {
//   final String listName;
//   final String className;
//   const AssignPage({Key? key, required this.listName, required this.className}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Assignment'),
//       ),
//       body: StreamBuilder<DocumentSnapshot>(
//         stream: FirebaseFirestore.instance
//             .collection('assign')
//             .doc(className)
//             .collection(listName)
//             .doc('Info')
//             .snapshots(),
//         builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//
//           if (!snapshot.hasData || snapshot.data!.data() == null) {
//             return Center(
//               child: Text('No data found for $listName.'),
//             );
//           }
//
//           var data = snapshot.data!.data() as Map<String, dynamic>;
//
//           return Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 8), // Adjust spacing between top and first ListTile
//               Container(
//                 padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//                 child: Row(
//                   children: [
//                     Text('Assignment Title: $listName'),
//                   ],
//                 ),
//               ),
//               Container(
//                 padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//                 child: Row(
//                   children: [
//                     Text('Description: ${data['Content'] ?? ''}'),
//                   ],
//                 ),
//               ),
//               Container(
//                 padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//                 child: Row(
//                   children: [
//                     Text('Subject: ${data['Subject'] ?? ''}'),
//                   ],
//                 ),
//               ),
//               Container(
//                 padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//                 child: Row(
//                   children: [
//                     Text('Assigned Date: ${_formatDate(data['AssignDate'])}'),
//                   ],
//                 ),
//               ),
//               Container(
//                 padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//                 child: Row(
//                   children: [
//                     Text('Due Date: ${_formatDate(data['DueDate'])}'),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 8.0), // Adjust spacing between last item and next widget
//               Container(
//                 padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
//                 child: const Row(
//                   children: [
//                     Text('Images for reference: '),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 8.0),
//               Expanded(
//                 child: StreamBuilder<QuerySnapshot>(
//                   stream: FirebaseFirestore.instance
//                       .collection('assign')
//                       .doc(className)
//                       .collection(listName)
//                       .doc('Info')
//                       .collection('images')
//                       .snapshots(),
//                   builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return const Center(
//                         child: CircularProgressIndicator(),
//                       );
//                     }
//
//                     if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//                       return const Text('No images available');
//                     }
//                     var imageUrls = snapshot.data!.docs.map((doc) => doc['imageUrl'] as String).toList();
//                     return Column(
//                       children: [
//                         // Adjust spacing above GridView
//                         const SizedBox(height: 8),
//                         MediaQuery.removePadding(
//                           context: context,
//                           removeTop: true,
//                           child: _buildImagesGridView(imageUrls),
//                         ),
//                       ],
//                     );
//                   },
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _pickMedia,
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
//
//   Future<void> _pickMedia() async {
//     final picker = ImagePicker();
//     final pickedImages = await picker.pickMultiImage();
//
//     for (var pickedImage in pickedImages) {
//       File imageFile = File(pickedImage.path);
//       await _uploadImageToFirebase(imageFile);
//     }
//   }
//
//   Future<void> _uploadImageToFirebase(File imageFile) async {
//     try {
//       FirebaseStorage storage = FirebaseStorage.instance;
//       String imageName = DateTime.now().toString(); // Use a unique name for the image
//       Reference ref = storage.ref().child("images").child(imageName);
//       UploadTask uploadTask = ref.putFile(imageFile);
//       TaskSnapshot taskSnapshot = await uploadTask;
//       String imageUrl = await taskSnapshot.ref.getDownloadURL();
//
//       // Save the image URL to Firestore
//       await FirebaseFirestore.instance
//           .collection('assign')
//           .doc(className)
//           .collection('Write an essay')
//           .doc('Info')
//           .collection('SubmittedStudents')
//           .doc('Diksha Jadhav')
//           .collection('homework')
//           .doc()
//           .set({
//         'imageUrl': imageUrl,
//       });
//     } catch (e) {
//       if (kDebugMode) {
//         print('Error uploading image: $e');
//       }
//       // Handle error
//     }
//   }
//
//   String _formatDate(dynamic date) {
//     if (date is Timestamp) {
//       DateTime dateTime = date.toDate();
//       return DateFormat('MMMM d, y').format(dateTime);
//     } else if (date is String) {
//       return date;
//     } else {
//       return '';
//     }
//   }
//
//   Widget _buildImagesGridView(List<String> imageUrls) {
//     if (imageUrls.isEmpty) {
//       return Center(
//         child: Text('No images available'),
//       );
//     } else {
//       return GridView.builder(
//         shrinkWrap: true,
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 3,
//           mainAxisSpacing: 8.0,
//           crossAxisSpacing: 8.0,
//           childAspectRatio: 1.0,
//         ),
//         itemCount: imageUrls.length,
//         itemBuilder: (BuildContext context, int index) {
//           return ClipRRect(
//             borderRadius: BorderRadius.circular(8.0), // Curved corners for images
//             child: GestureDetector(
//               onTap: () => _showImageGallery(context, imageUrls, index),
//               child: Image.network(
//                 imageUrls[index],
//                 fit: BoxFit.cover,
//               ),
//             ),
//           );
//         },
//         padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//       );
//     }
//   }
//
//
//   void _showImageGallery(BuildContext context, List<String> imageUrls, int initialIndex) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => Scaffold(
//           appBar: AppBar(),
//           body: PhotoViewGallery.builder(
//             itemCount: imageUrls.length,
//             builder: (context, index) {
//               return PhotoViewGalleryPageOptions(
//                 imageProvider: NetworkImage(imageUrls[index]),
//                 initialScale: PhotoViewComputedScale.contained,
//                 minScale: PhotoViewComputedScale.contained,
//                 maxScale: PhotoViewComputedScale.covered * 2,
//               );
//             },
//             scrollPhysics: const BouncingScrollPhysics(),
//             loadingBuilder: (context, event) => const Center(
//               child: CircularProgressIndicator(),
//             ),
//             backgroundDecoration: const BoxDecoration(color: Colors.black),
//             pageController: PageController(initialPage: initialIndex),
//           ),
//         ),
//       ),
//     );
//   }
//
//   // Function to load images from Firestore and display them in grid view
//   Widget _loadImagesAndDisplayGridView() {
//     return Expanded(
//       child: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance
//             .collection('assign')
//             .doc(className)
//             .collection(listName)
//             .doc('Info')
//             .collection('SubmittedStudents')
//             .doc('Diksha Jadhav')
//             .collection('homework')
//             .snapshots(),
//         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//
//           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//             return const Text('No images available');
//           }
//           var imageUrls = snapshot.data!.docs.map((doc) => doc['imageUrl'] as String).toList();
//           return Column(
//             children: [
//               // Adjust spacing above GridView
//               const SizedBox(height: 8),
//               MediaQuery.removePadding(
//                 context: context,
//                 removeTop: true,
//                 child: _buildImagesGridView(imageUrls),
//               ),
//               const Divider(color: Colors.black), // Black Divider after images
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
