import 'package:flutter/material.dart';
import 'package:vidyaniketan_app/screens/stud_att_screen.dart';

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
            content: Text("Assignments"),
          ));
        }
        else if(category.name=="Events"){
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Events"),
          ));
        }
        else if(category.name=="Bus Tracking"){
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Bus Tracking"),
          ));
        }
        else if(category.name=="Attendance"){
          Navigator.push(context,MaterialPageRoute(builder: (context)=>StudentAttendanceScreen()));
        }
        else if(category.name=="Certificates"){
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Certifcates"),
          ));
        }
        else if(category.name=="Report Card"){
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Report Card"),
          ));
        }
        else{
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Quiz"),
          ));
        }

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