import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:vidyaniketan_app/screens/quiz_screen.dart';

class QuizListScreen extends StatefulWidget {
  const QuizListScreen({super.key});

  @override
  State<QuizListScreen> createState() => _QuizListScreenState();
}

class _QuizListScreenState extends State<QuizListScreen> {
  final CollectionReference quiz =
  FirebaseFirestore.instance.collection('class1Quiz');

  Stream<QuerySnapshot> getQuizStream(){
    final busesStream = quiz.snapshots();
    return busesStream;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Quiz List",style: TextStyle(fontSize: 24),),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: getQuizStream(),
          builder: (context,snapshots){
            if(snapshots.hasData){
              List quizList = snapshots.data!.docs;

              return ListView.builder(
                  itemCount: quizList.length,
                  itemBuilder: (context,index){
                    DocumentSnapshot document =quizList[index];
                    String docId =document.id;

                    //get busNo from each doc
                    Map<String,dynamic> data =
                    document.data() as Map<String,dynamic>;

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            side: BorderSide(
                              color: Colors.black,
                            )
                        ),
                        title: Text(
                          "Quiz Name: "+docId,
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>const QuizScreen()));
                            }, icon: const Icon(Icons.arrow_circle_right_outlined))
                          ],
                        ),
                      ),
                    );


                  });
            }
            else{
              return const Text("No quiz's..");
            }
          },
        )
    );
  }
}