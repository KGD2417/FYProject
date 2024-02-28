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

const List<QuestionModel> questions = [
  QuestionModel(
      question: '1. Which is the biggest star among the following?',
      correctAnswerIndex: 0,
      options: [
        'a)Sun',
        'b)Polaris',
        'c)North Star',
        'd)None of the above',
      ]
  ),
  QuestionModel(
      question: '2. What is the percentage of fresh water on earth?',
      correctAnswerIndex: 2,
      options: [
        'a)99',
        'b)51',
        'c)3',
        'd)100',
      ]
  ),
  QuestionModel(
      question: '3. Who wrote national anthem?',
      correctAnswerIndex: 1,
      options: [
        'a)Arijit Singh',
        'b)Rabindranath Tagore',
        'c)Anuv Jain',
        'd)Bankim Chandra Chatterjee',
      ]
  ),
  QuestionModel(
      question: '4.Who is the founder of TATA?',
      correctAnswerIndex: 1,
      options: [
        'a)Ratanji Tata',
        'b)Jamsetji Tata',
        'c)Ratan Tata',
        'd)J.R.D. Tata',
      ]
  ),
];