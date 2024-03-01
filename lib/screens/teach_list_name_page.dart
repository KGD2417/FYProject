import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:photo_view/photo_view.dart';

class ListNamePage extends StatefulWidget {
  final String listName;
  final String className;
  final String studentDocumentId;

  const ListNamePage({
    Key? key,
    required this.listName,
    required this.className,
    required this.studentDocumentId,
  }) : super(key: key);

  @override
  _ListNamePageState createState() => _ListNamePageState();
}

class _ListNamePageState extends State<ListNamePage> {
  late Stream<List<String>> _imageUrlsStream;

  @override
  void initState() {
    super.initState();
    _loadImages();
  }

  void _loadImages() {
    _imageUrlsStream = FirebaseFirestore.instance
        .collection('assign')
        .doc(widget.className)
        .collection(widget.listName)
        .doc('Info')
        .collection('SubmittedStudents')
        .doc(widget.studentDocumentId)
        .collection('homework')
        .get()
        .then((querySnapshot) {
      List<String> imageUrls = [];
      for (var doc in querySnapshot.docs) {
        var imageUrl = doc.get('imageUrl');
        if (imageUrl != null && imageUrl.isNotEmpty) {
          imageUrls.add(imageUrl);
        }
      }
      return imageUrls;
    }).asStream();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.studentDocumentId),
      ),
      body: StreamBuilder<List<String>>(
        stream: _imageUrlsStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: LottieBuilder.asset(
                  "assets/images/Loading.json",
                )
            );
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
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
    Key? key,
    required this.imageUrls,
    required this.initialIndex,
  }) : super(key: key);

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
