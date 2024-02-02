import 'package:flutter/material.dart';
import 'package:vidyaniketan_app/widgets/days_list.dart';

class DaysCard extends StatefulWidget {
  final DaysList days;
  const DaysCard({
    Key? key,
    required this.days,
  }) : super(key: key);

  @override
  State<DaysCard> createState() => _DaysCardState();
}


class _DaysCardState extends State<DaysCard> {

  int designatedColor = 0xFFe4f1ff;


  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 5),  
        decoration: BoxDecoration(
          color: widget.days.currentDay?Color(0xFF0f6cbd): Color(0xFFe4f1ff),
          borderRadius: BorderRadius.circular(15),
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
            Text(widget.days.name,style: Theme.of(context).textTheme.headlineSmall,),
          ],
        ),
      ),
    );
  }
}