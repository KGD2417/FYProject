import 'package:flutter/material.dart';

/* if
  else
  else
 */

class AnswerCard extends StatelessWidget{
  const AnswerCard(
  {
    super.key,
    required this.question,
    required this.isSelected,
    required this.currentIndex,
    required this.correctAnswerIndex,
    required this.selectedAnswerIndex,
});

  final String question;
  final bool isSelected;
  final int currentIndex;
  final int?correctAnswerIndex;
  final int? selectedAnswerIndex;

  @override
  Widget build(BuildContext context)
  {
    bool isCorrectAnswer = currentIndex == correctAnswerIndex;
    bool isWrongAnswer = !isCorrectAnswer && isSelected;
    return Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10.0,
        ),
      child:
      selectedAnswerIndex != null

        ? Container(
            height: 70,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              // color: Color(0xFF0e6cbc),
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                width: 2,
                color: isCorrectAnswer
                  ? Colors.green
                    : isWrongAnswer
                  ?
                    Colors.red
                    :Color(0xFF0e6cbc),
              )
            ),
            child: Row(
              children: [
                Expanded(
                    child: Text(
                      question,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Color(0xFF0e6cbc),
                      ),
                    )
                ),
                const SizedBox(height: 10),
                isCorrectAnswer
                ? buildCorrectIcon()
                    :isWrongAnswer
                ?buildWrongIcon()
                   : const SizedBox.shrink(),
              ],
            ),
          ) : Container(
        height: 70,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Color(0xFF0e6cbc),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: Colors.white,
      ),
    ),
            child: Row(
                children: [
                    Expanded(
                      child: Text(
                          question,
                          style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          ),
                            ),
                            ),
    ],
    ),
                            ),
    );
  }
}

Widget buildCorrectIcon() => const CircleAvatar(
  radius: 15,
  backgroundColor: Colors.green,
  child: Icon(
    Icons.check,
    color: Colors.white,
  ),
);

Widget buildWrongIcon() => const CircleAvatar(
  radius: 15,
  backgroundColor: Colors.red,
  child: Icon(
    Icons.close,
    color: Colors.white,
  ),
);