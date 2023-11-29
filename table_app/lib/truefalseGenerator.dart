int totalQuestions = 7;
int tableNumber = 2;
int lowerLimit = 5;
int upperLimit = 10;

int limit = 1;

class TruefalseQuestions {
  static final TruefalseQuestions _instance = TruefalseQuestions._internal();

  factory TruefalseQuestions() {
    return _instance;
  }
  
  TruefalseQuestions._internal();

  final List<Map<String, dynamic>> _questions = [];

  void generateQuestions() {
    List<int> numbers =
        List.generate(upperLimit - lowerLimit, (index) => index + lowerLimit);
    numbers.shuffle();

    for (int i = 0; i < totalQuestions; i++) {

      if (i >= numbers.length) {
        limit = numbers[i - numbers.length];
      } else {
        limit = numbers[i];
      }

      String flag = 'True';
      List<int> rand = [1,0,2];
      rand.shuffle();

      int qa = tableNumber*limit;
      if((rand[0])==0) {
        qa *= 2;
      }

      if(qa!= tableNumber*limit) {
        flag='False';
      }

      Map<String, dynamic> newQuestion = {
        'question': 'Is $tableNumber * $limit equals to $qa ?',
        'choices': ['True', 'False'],
        'correctAnswer': flag,
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
