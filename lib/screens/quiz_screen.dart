import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vidyaniketan_app/app.dart';

class QuizScreen extends StatefulWidget {

  const QuizScreen({Key? key}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  String quizName = "bb";

  CollectionReference quizRef = FirebaseFirestore.instance.collection('class1Quiz');

  String quests = "";
  int correctAnsIndex = 0;
  List<List<String>> options = [];


  @override
  void initState() {

    quizRef.doc(quizName).get().then((DocumentSnapshot snapshot){
      quests = snapshot.get('question1');
      correctAnsIndex = snapshot.get('correctAns1');
      options[0]= snapshot.get('options1');

    });

    setState(() {

    });

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(quizName),
        centerTitle: true,
      ),
      body: Text(quests),
    );
  }
}

class QuestionModel{
  final String question;
  final List<String> options;
  final int correctAnswerIndex;

  const QuestionModel({
    required this.correctAnswerIndex,
    required this.question,
    required this.options,

  });
}

