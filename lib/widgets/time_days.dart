import 'package:flutter/material.dart';
import 'package:vidyaniketan_app/screens/timetable_screen.dart';
import 'package:vidyaniketan_app/widgets/days_list.dart';
//
// class TimeDaysCard extends StatefulWidget {
//   final DaysList days;
//
//   const TimeDaysCard({
//     Key? key,
//     required this.days,
//   }) : super(key: key);
//
//   @override
//   State<TimeDaysCard> createState() => _TimeDaysCardState();
// }
//
//
// class _TimeDaysCardState extends State<TimeDaysCard> {
//
//   int designatedColor = 0xFFe4f1ff;
//
//
//   @override
//   void initState() {
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         if(widget.days.actualName=="Mon"){
//           ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//             content: Text("Monday"),//
//           ));
//         }
//         else if(widget.days.actualName=="Tue"){
//           ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//             content: Text("Tuesday"),//
//           ));
//         }
//         else if(widget.days.actualName=="Wed"){
//           ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//             content: Text("Wednesday"),//
//           ));
//         }
//         else if(widget.days.actualName=="Thu"){
//           ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//             content: Text("Thursday"),//
//           ));
//         }
//         else if(widget.days.actualName=="Fri"){
//           ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//             content: Text("Friday"),//
//           ));
//         }
//       },
//       child: Container(
//         padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 5),
//         decoration: BoxDecoration(
//           color: widget.days.currentDay?Color(0xFF0f6cbd): Color(0xFFe4f1ff),
//           borderRadius: BorderRadius.circular(15),
//           border: Border.all(width: 1,color: Color(0xFF0f6cbd)),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(.1),
//               blurRadius: 4.0,
//               spreadRadius: .05,
//             ), //BoxShadow
//           ],
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Text(widget.days.name,style: TextStyle(
//                 color: widget.days.currentDay? Colors.white:Colors.black,
//                 fontWeight: FontWeight.bold
//             ),),
//           ],
//         ),
//       ),
//     );
//   }
// }