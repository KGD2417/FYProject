import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:vidyaniketan_app/screens/bus_screen.dart';

class TeachQuizListScreen extends StatefulWidget {
  const TeachQuizListScreen({super.key});

  @override
  State<TeachQuizListScreen> createState() => _TeachQuizListScreenState();
}

class _TeachQuizListScreenState extends State<TeachQuizListScreen> {
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>const CreateQuiz()));
          },
          child: const Icon(Iconsax.element_plus),
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
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>const CreateQuiz()));
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

class QuizDetails extends StatefulWidget {
  const QuizDetails({super.key});

  @override
  State<QuizDetails> createState() => _QuizDetailsState();
}

class _QuizDetailsState extends State<QuizDetails> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}



class CreateQuiz extends StatefulWidget {
  const CreateQuiz({super.key});

  @override
  State<CreateQuiz> createState() => _CreateQuizState();
}

class _CreateQuizState extends State<CreateQuiz> {

  CollectionReference class1 = FirebaseFirestore.instance.collection('class1Quiz');

  TextEditingController quizNameController = TextEditingController();
  TextEditingController question1Controller = TextEditingController();
  TextEditingController ans1Controller = TextEditingController();

  TextEditingController question2Controller = TextEditingController();
  TextEditingController ans2Controller = TextEditingController();

  TextEditingController question3Controller = TextEditingController();
  TextEditingController ans3Controller = TextEditingController();

  TextEditingController question4Controller = TextEditingController();
  TextEditingController ans4Controller = TextEditingController();

  TextEditingController question5Controller = TextEditingController();
  TextEditingController ans5Controller = TextEditingController();

  TextEditingController option11Controller = TextEditingController();
  TextEditingController option12Controller = TextEditingController();
  TextEditingController option13Controller = TextEditingController();
  TextEditingController option14Controller = TextEditingController();

  TextEditingController option21Controller = TextEditingController();
  TextEditingController option22Controller = TextEditingController();
  TextEditingController option23Controller = TextEditingController();
  TextEditingController option24Controller = TextEditingController();

  TextEditingController option31Controller = TextEditingController();
  TextEditingController option32Controller = TextEditingController();
  TextEditingController option33Controller = TextEditingController();
  TextEditingController option34Controller = TextEditingController();

  TextEditingController option41Controller = TextEditingController();
  TextEditingController option42Controller = TextEditingController();
  TextEditingController option43Controller = TextEditingController();
  TextEditingController option44Controller = TextEditingController();

  TextEditingController option51Controller = TextEditingController();
  TextEditingController option52Controller = TextEditingController();
  TextEditingController option53Controller = TextEditingController();
  TextEditingController option54Controller = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    quizNameController.dispose();
    question1Controller.dispose();
    question2Controller.dispose();
    question3Controller.dispose();
    question4Controller.dispose();
    question5Controller.dispose();
    ans1Controller.dispose();
    ans2Controller.dispose();
    ans3Controller.dispose();
    ans4Controller.dispose();
    ans5Controller.dispose();
    option11Controller.dispose();
    option12Controller.dispose();
    option13Controller.dispose();
    option14Controller.dispose();
    option21Controller.dispose();
    option22Controller.dispose();
    option23Controller.dispose();
    option24Controller.dispose();
    option31Controller.dispose();
    option32Controller.dispose();
    option33Controller.dispose();
    option34Controller.dispose();
    option41Controller.dispose();
    option42Controller.dispose();
    option43Controller.dispose();
    option44Controller.dispose();
    option51Controller.dispose();
    option52Controller.dispose();
    option53Controller.dispose();
    option54Controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Quiz"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: Column(
              children: [

                TextFormField(
                  
                  controller: quizNameController,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.quiz),
                      labelText: "Quiz Name",
                      hintText: "Enter Quiz Name"),
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter a valid Quiz Name';
                    }
                    return null;
                  },
                ),

                const SizedBox(
                  height: 40,
                ),


                TextFormField(
                  controller: question1Controller,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.question_mark),
                      labelText: "Question1",
                      hintText: "Enter Question1"),
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter a valid Question1';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: ans1Controller,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.question_answer),
                      labelText: "Correct Option 1",
                      hintText: "Enter Option1"),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter a valid Option1';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: option11Controller,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.format_list_numbered),
                      labelText: "Option1",
                      hintText: "Enter Option1"),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter a valid Option1';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: option12Controller,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.format_list_numbered),
                      labelText: "Option2",
                      hintText: "Enter Option2"),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter a valid Option2';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: option13Controller,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.format_list_numbered),
                      labelText: "Option3",
                      hintText: "Enter Option3"),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter a valid Option3';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: option14Controller,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.format_list_numbered),
                      labelText: "Option4",
                      hintText: "Enter Option4"),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter a valid Option4';
                    }
                    return null;
                  },
                ),

                const SizedBox(
                  height: 30,
                ),





                TextFormField(
                  controller: question2Controller,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.question_mark),
                      labelText: "Question2",
                      hintText: "Enter Question2"),
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter a valid Question2';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: ans2Controller,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.question_answer),
                      labelText: "Correct Option 2",
                      hintText: "Enter Option2"),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter a valid Option2';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: option21Controller,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.format_list_numbered),
                      labelText: "Option1",
                      hintText: "Enter Option1"),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter a valid Option1';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: option22Controller,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.format_list_numbered),
                      labelText: "Option2",
                      hintText: "Enter Option2"),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter a valid Option2';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: option23Controller,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.format_list_numbered),
                      labelText: "Option3",
                      hintText: "Enter Option3"),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter a valid Option3';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: option24Controller,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.format_list_numbered),
                      labelText: "Option4",
                      hintText: "Enter Option4"),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter a valid Option4';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 30,
                ),





                TextFormField(
                  controller: question3Controller,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.question_mark),
                      labelText: "Question3",
                      hintText: "Enter Question3"),
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter a valid Question3';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: ans3Controller,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.question_answer),
                      labelText: "Correct Option 3",
                      hintText: "Enter Option3"),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter a valid Option3';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: option31Controller,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.format_list_numbered),
                      labelText: "Option1",
                      hintText: "Enter Option1"),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter a valid Option1';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: option32Controller,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.format_list_numbered),
                      labelText: "Option2",
                      hintText: "Enter Option2"),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter a valid Option2';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: option33Controller,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.format_list_numbered),
                      labelText: "Option3",
                      hintText: "Enter Option3"),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter a valid Option3';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: option34Controller,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.format_list_numbered),
                      labelText: "Option4",
                      hintText: "Enter Option4"),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter a valid Option4';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 30,
                ),





                TextFormField(
                  controller: question4Controller,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.question_mark),
                      labelText: "Question4",
                      hintText: "Enter Question4"),
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter a valid Question4';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: ans4Controller,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.question_answer),
                      labelText: "Correct Option 4",
                      hintText: "Enter Option4"),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter a valid Option4';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: option41Controller,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.format_list_numbered),
                      labelText: "Option1",
                      hintText: "Enter Option1"),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter a valid Option1';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: option42Controller,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.format_list_numbered),
                      labelText: "Option2",
                      hintText: "Enter Option2"),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter a valid Option2';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: option43Controller,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.format_list_numbered),
                      labelText: "Option3",
                      hintText: "Enter Option3"),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter a valid Option3';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: option44Controller,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.format_list_numbered),
                      labelText: "Option4",
                      hintText: "Enter Option4"),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter a valid Option4';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 30,
                ),






                TextFormField(
                  controller: question5Controller,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.question_mark),
                      labelText: "Question5",
                      hintText: "Enter Question5"),
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter a valid Question5';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: ans5Controller,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.question_answer),
                      labelText: "Correct Option 5",
                      hintText: "Enter Option5"),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter a valid Option5';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: option51Controller,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.format_list_numbered),
                      labelText: "Option1",
                      hintText: "Enter Option1"),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter a valid Option1';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: option52Controller,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.format_list_numbered),
                      labelText: "Option2",
                      hintText: "Enter Option2"),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter a valid Option2';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: option53Controller,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.format_list_numbered),
                      labelText: "Option3",
                      hintText: "Enter Option3"),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter a valid Option3';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: option54Controller,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.format_list_numbered),
                      labelText: "Option4",
                      hintText: "Enter Option4"),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter a valid Option4';
                    }
                    return null;
                  },
                ),

                const SizedBox(
                  height: 30,
                ),

                SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                        onPressed: (){
                          if(_formKey.currentState!.validate()){

                            String quizName = quizNameController.text.toString();

                            // List<String> questions = [];
                            // List<int> correctAns = [];

                            String questions1 = question1Controller.text.toString();
                            List<String> options1 =
                            [
                              option11Controller.text,
                              option12Controller.text,
                              option13Controller.text,
                              option14Controller.text
                            ];
                            int correctAns1 = int.parse(ans1Controller.text)-1;


                            String questions2 = question2Controller.text.toString();
                            List<String> options2 =
                            [
                              option21Controller.text,
                              option22Controller.text,
                              option23Controller.text,
                              option24Controller.text
                            ];
                            int correctAns2 = int.parse(ans2Controller.text)-1;


                            String questions3 = question3Controller.text.toString();
                            List<String> options3 =
                            [
                              option31Controller.text,
                              option32Controller.text,
                              option33Controller.text,
                              option34Controller.text
                            ];
                            int correctAns3 = int.parse(ans3Controller.text)-1;


                            String questions4 = question4Controller.text.toString();
                            List<String> options4 =
                            [
                              option41Controller.text,
                              option42Controller.text,
                              option43Controller.text,
                              option44Controller.text
                            ];
                            int correctAns4 = int.parse(ans4Controller.text)-1;


                            String questions5 = question5Controller.text.toString();
                            List<String> options5 =
                            [
                              option51Controller.text,
                              option52Controller.text,
                              option53Controller.text,
                              option54Controller.text
                            ];
                            int correctAns5 = int.parse(ans5Controller.text)-1;

                            class1.doc(quizName).set({
                              'question1': questions1,
                              'correctAns1': correctAns1,
                              'options1': options1,

                              'question2': questions2,
                              'correctAns2': correctAns2,
                              'options2': options2,

                              'question3': questions3,
                              'correctAns3': correctAns3,
                              'options3': options3,

                              'question4': questions4,
                              'correctAns4': correctAns4,
                              'options4': options4,

                              'question5': questions5,
                              'correctAns5': correctAns5,
                              'options6': options5
                            });


                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Quiz Created")));
                            Navigator.pop(context);
                          }
                        },
                        child: Text(
                          "Create Quiz",
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: GoogleFonts
                                  .poppins()
                                  .fontFamily),
                        )
                    )
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}








