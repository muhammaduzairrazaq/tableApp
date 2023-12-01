import 'package:table_app/QuizParameters.dart';

int limit = 1;

class Questions {
  static final Questions _instance = Questions._internal();

  factory Questions() {
    return _instance;
  }

  Questions._internal();

  final List<Map<String, dynamic>> _questions = [];

  void generateQuestions() {
    int totalQuestions = QuizParameters.questionNumbers;
    int tableNumber = QuizParameters.tableNumber;
    int lowerLimit = QuizParameters.lowerLimit;
    int upperLimit = QuizParameters.upperLimit;

    _questions.clear();
    List<int> numbers =
        List.generate(upperLimit - lowerLimit, (index) => index + lowerLimit);
    numbers.shuffle();

    for (int i = 0; i < totalQuestions; i++) {
      if (i >= numbers.length) {
        limit = numbers[i - numbers.length];
      } else {
        limit = numbers[i];
      }

      List<String> choices = [];
      for (int i = 0; i < 4; i++) {
        choices.add('${tableNumber * (limit + i)}');
      }
      choices.shuffle();

      Map<String, dynamic> newQuestion = {
        'question': 'What is $tableNumber * $limit ?',
        'choices': choices,
        'correctAnswer': '${tableNumber * limit}',
      };

      _questions.add(newQuestion);
    }
  }

  Map<String, dynamic>? getQuestion(int index) {
    if (index >= 0 && index < _questions.length) {
      return _questions[index];
    }
    return null;
  }

  int getQuestionCount() {
    return _questions.length;
  }

  String? getCorrectAnswer(int questionIndex) {
    if (questionIndex >= 0 && questionIndex < _questions.length) {
      return _questions[questionIndex]['correctAnswer'];
    }
    return null;
  }
}
