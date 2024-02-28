import 'package:flutter/material.dart';
import 'package:vidyaniketan_app/screens/quiz_screen.dart';

import '../models/questions.dart';
import '../widgets/next_button.dart';

class ResultScreen extends StatelessWidget{
  const ResultScreen({
    super.key,
    required this.score,
  });
  final int score;

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Color(0xFF0e6cbc),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 150,
            ),
            const Text(
              'Your Score: ',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w500,
                color: Color(0xFFffda1d),
              ),
            ),
            SizedBox(
              height: 150,
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: 250,
                  width: 250,
                  child: CircularProgressIndicator(
                    strokeWidth: 12,
                    value: score/4,
                    color: Colors.lightGreen,
                    backgroundColor: Colors.white,
                  ),
                ),
                Column(
                  children: [
                    Text(
                      score.toString() + "/4",
                      style: const TextStyle(fontSize: 80,
                        color: Color(0xFFE4F1FF),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '${(score/questions.length*100).round()}%',
                      style: const TextStyle(fontSize: 30,color: Color(0xFFE4F1FF)),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: 150),

            RectangularButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (_) => QuizScreen(),
                    ),
                  );
                },
                label: 'Restart')
          ],
        ),
      ),
    );
  }

}