import 'package:flutter/material.dart';
import 'package:vidyaniketan_app/screens/attendance_screen.dart';
import 'package:vidyaniketan_app/screens/bus_list.dart';
import 'package:vidyaniketan_app/screens/events_list.dart';
import 'package:vidyaniketan_app/screens/stud_att_screen.dart';
import 'package:vidyaniketan_app/screens/stud_event_list.dart';
import 'package:vidyaniketan_app/screens/stud_quiz.dart';
import '../screens/teach_quiz.dart';
import 'cat_lis.dart';

class CategoryCard extends StatelessWidget {
  final Category category;
  const CategoryCard({
    Key? key,
    required this.category,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if(category.name=="Assignments"){
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Assignments"),//
          ));
        }
        else if(category.name=="Events"){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>StudEventListPage()));
        }
        else if(category.name=="Bus Tracking"){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>BusListScreen()));
        }//b
        else if(category.name=="Attendance"){
          Navigator.push(context,MaterialPageRoute(builder: (context)=>StudentAttendanceScreen()));
        }
        else if(category.name=="Report Card"){
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Report Card"),
          ));
        }//k
        else{
          Navigator.push(context,MaterialPageRoute(builder: (context)=>QuizListScreen()));
        }//j

      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 5),
        decoration: BoxDecoration(
          color: const Color(0xFFe4f1ff),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(width: 1,color: Color(0xFF0f6cbd)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.1),
              blurRadius: 4.0,
              spreadRadius: .05,
            ), //BoxShadow
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                category.thumbnail,
                height: 50,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(category.name,style: Theme.of(context).textTheme.bodyLarge,),
          ],
        ),
      ),
    );
  }
}



class CategoryTeacherCard extends StatelessWidget {
  final Category category;
  const CategoryTeacherCard({
    Key? key,
    required this.category,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if(category.name=="Assignments"){
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Assignments"),//
          ));
        }
        else if(category.name=="Events"){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>EventListPage()));
        }
        else if(category.name=="Bus Tracking"){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>BusListScreen()));
        }//b
        else if(category.name=="Attendance"){
          Navigator.push(context,MaterialPageRoute(builder: (context)=>AttendanceScreen()));
        }
        else if(category.name=="Report Card"){
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Report Card"),
          ));
        }//k
        else{
          Navigator.push(context, MaterialPageRoute(builder: (context)=>TeachQuizListScreen()));
        }//j

      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 5),
        decoration: BoxDecoration(
          color: const Color(0xFFe4f1ff),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(width: 1,color: Color(0xFF0f6cbd)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.1),
              blurRadius: 4.0,
              spreadRadius: .05,
            ), //BoxShadow
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                category.thumbnail,
                height: 50,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(category.name,style: Theme.of(context).textTheme.bodyLarge,),
          ],
        ),
      ),
    );
  }
}