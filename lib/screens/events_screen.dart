import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';
import 'dart:io';

// class Event extends StatelessWidget {
//   final String eventName;
//   const Event({super.key, required this.eventName});
//
//   @override
//   Widget build(BuildContext context) {
//     return
//   }
// }

class MediaGalleryScreen extends StatefulWidget {
  final String eventName;
  const MediaGalleryScreen({super.key, required this.eventName});

  @override
  _MediaGalleryScreenState createState() => _MediaGalleryScreenState();
}

class _MediaGalleryScreenState extends State<MediaGalleryScreen> {
  late Stream<List<String>> _imageUrlsStream;

  @override
  void initState() {
    super.initState();
    _loadImages();
  }

  void _loadImages() {
    _imageUrlsStream = FirebaseFirestore.instance
        .collection('event')
        .doc(widget.eventName)
        .collection('images')
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => doc.get('imageUrl').toString())
        .toList());
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
      Reference ref = storage.ref().child("images/${widget.eventName}/${DateTime.now()}");
      UploadTask uploadTask = ref.putFile(imageFile);
      TaskSnapshot taskSnapshot = await uploadTask;
      String imageUrl = await taskSnapshot.ref.getDownloadURL();

      // Save the image URL to Firestore
      await FirebaseFirestore.instance
          .collection('event')
          .doc(widget.eventName)
          .collection('images')
          .add({
        'imageUrl': imageUrl,
        'timestamp': FieldValue.serverTimestamp(), // Optional: include timestamp
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error uploading image: $e');
      }
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Media Gallery'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _pickMedia,
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<List<String>>(
        stream: _imageUrlsStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No images available'));
          }
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FullScreenImageViewer(
                        imageUrls: snapshot.data!,
                        initialIndex: index,
                      ),
                    ),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    snapshot.data![index],
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class FullScreenImageViewer extends StatelessWidget {
  final List<String> imageUrls;
  final int initialIndex;
  const FullScreenImageViewer({
    super.key,
    required this.imageUrls,
    required this.initialIndex,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: PageView.builder(
        itemCount: imageUrls.length,
        controller: PageController(initialPage: initialIndex),
        itemBuilder: (context, index) {
          return PhotoView(
            imageProvider: NetworkImage(imageUrls[index]),
            backgroundDecoration: const BoxDecoration(
              color: Colors.black,
            ),
          );
        },
      ),
    );
  }
}
