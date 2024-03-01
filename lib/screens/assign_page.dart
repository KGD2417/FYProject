import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:intl/intl.dart';

class AssignPage extends StatelessWidget {
  final String listName;
  const AssignPage({Key? key, required this.listName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assignment'),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('assign')
            .doc('Class1')
            .collection(listName)
            .doc('Info')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: LottieBuilder.asset(
                  "assets/images/Loading.json",
                )
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
              const SizedBox(height: 8), // Adjust spacing between top and first ListTile
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Row(
                  children: [
                    Text('Assignment Title: $listName'),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Row(
                  children: [
                    Text('Description: ${data['Content'] ?? ''}'),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Row(
                  children: [
                    Text('Subject: ${data['Subject'] ?? ''}'),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Row(
                  children: [
                    Text('Assigned Date: ${_formatDate(data['AssignDate'])}'),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Row(
                  children: [
                    Text('Due Date: ${_formatDate(data['DueDate'])}'),
                  ],
                ),
              ),
              const SizedBox(height: 8.0), // Adjust spacing between last item and next widget
              Container(
                padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
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
                      .doc('Class1')
                      .collection(listName)
                      .doc('Info')
                      .collection('images')
                      .snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                          child: LottieBuilder.asset(
                            "assets/images/Loading.json",
                          )
                      );
                    }

                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Text('No images available');
                    }
                    var imageUrls = snapshot.data!.docs.map((doc) => doc['imageUrl'] as String).toList();
                    return Column(
                      children: [
                        // Adjust spacing above GridView
                        const SizedBox(height: 8),
                        MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          child: _buildImagesGridView(imageUrls),
                        ),
                        const Divider(color: Colors.black), // Black Divider after images
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                          child: Text('Your Answer:', style: TextStyle(fontSize: 15)),
                        ),
                        const SizedBox(height: 8), // Add some space below 'Your Answer'
                        // Call the function to load images and display them in grid view
                        _loadImagesAndDisplayGridView(),
                      ],
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _pickMedia,
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _pickMedia() async {
    final picker = ImagePicker();
    final pickedImages = await picker.pickMultiImage();

    for (var pickedImage in pickedImages) {
      File imageFile = File(pickedImage.path);
      await _uploadImageToFirebase(imageFile);
    }
  }

  Future<void> _uploadImageToFirebase(File imageFile) async {
    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      String imageName = DateTime.now().toString(); // Use a unique name for the image
      Reference ref = storage.ref().child("images").child(imageName);
      UploadTask uploadTask = ref.putFile(imageFile);
      TaskSnapshot taskSnapshot = await uploadTask;
      String imageUrl = await taskSnapshot.ref.getDownloadURL();

      // Save the image URL to Firestore
      await FirebaseFirestore.instance
          .collection('assign')
          .doc('Class1')
          .collection('Write an essay')
          .doc('Info')
          .collection('SubmittedStudents')
          .doc('Diksha Jadhav')
          .collection('homework')
          .doc()
          .set({
        'imageUrl': imageUrl,
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error uploading image: $e');
      }
      // Handle error
    }
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
      return Center(
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
            loadingBuilder: (context, event) => Center(
          child: LottieBuilder.asset(
          "assets/images/Loading.json",
          )
        ),
            backgroundDecoration: const BoxDecoration(color: Colors.black),
            pageController: PageController(initialPage: initialIndex),
          ),
        ),
      ),
    );
  }

  // Function to load images from Firestore and display them in grid view
  Widget _loadImagesAndDisplayGridView() {
    return Expanded(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('assign')
            .doc('Class1')
            .collection(listName)
            .doc('Info')
            .collection('SubmittedStudents')
            .doc('Diksha Jadhav')
            .collection('homework')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
            child: LottieBuilder.asset(
            "assets/images/Loading.json",
            )
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Text('No images available');
          }
          var imageUrls = snapshot.data!.docs.map((doc) => doc['imageUrl'] as String).toList();
          return SingleChildScrollView(
            child: Column(
              children: [
                // Adjust spacing above GridView
                const SizedBox(height: 8),
                MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: _buildImagesGridView(imageUrls),
                ),
                const Divider(color: Colors.black), // Black Divider after images
              ],
            ),
          );
        },
      ),
    );
  }
}
