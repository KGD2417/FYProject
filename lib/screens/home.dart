
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:vidyaniketan_app/screens/timetable_screen.dart';
import 'package:vidyaniketan_app/utils/date.dart' as date_util;
import 'package:vidyaniketan_app/widgets/days.dart';
import 'package:vidyaniketan_app/widgets/days_list.dart';

import '../utils/search_text_field.dart';
import '../widgets/cat_lis.dart';
import '../widgets/category.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              MyAppBar(),
              Body(),
            ],
          ),
        ),
      ),
    );
  }
}

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  double width = 0.0;
  double height = 0.0;
  late ScrollController scrollController;
  List<DateTime> currentMonthList = List.empty();
  DateTime currentDateTime = DateTime.now();
  List<String> todos = <String>[];
  TextEditingController controller = TextEditingController();

  String currentLec = "";

  final auth = FirebaseAuth.instance;
  String studName = "";


  @override
  void initState() {
    currentMonthList = date_util.DateUtils.daysInMonth(currentDateTime);
    currentMonthList.sort((a, b) => a.day.compareTo(b.day));
    currentMonthList = currentMonthList.toSet().toList();
    scrollController =
        ScrollController(initialScrollOffset: 70.0 * currentDateTime.day);

    CollectionReference usersRef = FirebaseFirestore.instance.collection('users');
    final user = auth.currentUser;
    usersRef.doc(user?.phoneNumber.toString()).get().then((DocumentSnapshot snapshot){
      setState(() {
        studName = snapshot.get('fname');
      });
    });

    (DateFormat('EEE').format(DateTime.now()) == "Sat" || DateFormat('EEE').format(DateTime.now()) == "Sun")? print("Holiday"): FirebaseFirestore.instance.collection('timetable').doc(date_util.DateUtils.weekdays[currentDateTime.weekday - 1]
        .toString()).get().then((DocumentSnapshot docSnap){
          DateTime time = DateTime.now();
          int bruh= (time.hour)+1;
          print("${time.hour}to$bruh");

          setState(() {
            currentLec = docSnap.get("${time.hour}to$bruh");
          });

    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  "Calender",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              )
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Divider(thickness: 1,color: Color(0xFF75ade7),),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 2, left: 20, right: 20),
          child: Container(
            height: (DateFormat('EEE').format(DateTime.now()) == "Sat" || DateFormat('EEE').format(DateTime.now()) == "Sun")?128 :158,
            width: double.infinity,
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Color(0xFFe4f1ff),
                boxShadow: [
                  BoxShadow(
                color: Colors.black.withOpacity(.1),
                blurRadius: 4.0,
                spreadRadius: .05,)
                ],
                border: Border.all(width: 1.5,color: Color(0xFF0f6cbd)),
                borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>TimeTableScreen()));
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          '${"${currentDateTime.day} " + date_util.DateUtils.months[currentDateTime.month - 1]} ${currentDateTime.year}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.black),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 150),
                          child: Icon(Iconsax.arrow_right,color: Colors.blue.shade900,),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      height: (DateFormat('EEE').format(DateTime.now()) == "Sat" || DateFormat('EEE').format(DateTime.now()) == "Sun")?70:100,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(15),
                              bottomLeft: Radius.circular(15),
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8))),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: (DateFormat('EEE').format(DateTime.now()) == "Sat" || DateFormat('EEE').format(DateTime.now()) == "Sun")?
                        Center(
                            child:Text("Holiday",style: Theme.of(context).textTheme.headlineLarge,)):
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Current Period: $currentLec",style: TextStyle(fontSize: 16),),
                            GridView.builder(
                              physics: const ScrollPhysics(),
                              shrinkWrap: true,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 5,
                                childAspectRatio: 1,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 30,
                              ),
                              itemBuilder: (context, index) {
                                return DaysCard(
                                  days: daysList[index],
                                );
                              },
                              itemCount: daysList.length,
                            ),
                          ],
                        ),
                      ),
                    ),
                    ]
                    ),
              )
                  )
                  )
                  ),

                  SizedBox(
                    height: 10,
                  ),
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0,),
                child: Text(
                  "Features",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Divider(thickness: 1,color: Color(0xFF75ade7),),
        ),
        GridView.builder(
          physics: const ScrollPhysics(),
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 8,
          ),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.8,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          itemBuilder: (context, index) {
            return CategoryCard(
              category: categoryList[index],
            );
          },
          itemCount: categoryList.length,
        ),
      ],
    );
  }
}

class MyAppBar extends StatefulWidget {
  const MyAppBar({super.key});

  @override
  State<MyAppBar> createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {


  final auth = FirebaseAuth.instance;
  String studName = "";

  @override
  void initState() {
    super.initState();

    CollectionReference usersRef = FirebaseFirestore.instance.collection('users');
    final user = auth.currentUser;
    usersRef.doc(user?.phoneNumber.toString()).get().then((DocumentSnapshot snapshot){
      setState(() {
        studName = snapshot.get('fname')+" "+snapshot.get("lname");
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
      height: 150,
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        color: Color(0xFF0f6cbd),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome,\n"+studName,
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const SearchTextField()
        ],
      ),
    );
  }
}
