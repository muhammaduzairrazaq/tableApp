import 'package:flutter/material.dart';
import 'scoreScreen.dart';
import 'questionGenerator.dart';

class QuestionsScreen extends StatefulWidget {

  @override
  _QuestionsScreenState createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  int _questionIndex = 0;
  int _realquestion = 1;
  int _correctAnswers = 0;
  bool _answered = false;

Questions ques = Questions();

  @override
  void initState() {
    super.initState();
  }

  void _handleAnswer(bool isCorrect) {
    if (isCorrect) {
      _correctAnswers++;
    }
    setState(() {
      _answered = true;
    });
  }

  void _nextQuestion() {
    if (_questionIndex < ques.getQuestionCount() - 1) {
      setState(() {
        _questionIndex++;
        _realquestion++;
        _answered = false;
      });
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ScoreScreen(
                  score: _correctAnswers,
                )),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? question = ques.getQuestion(_questionIndex);

    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Container(
                width: 350.0,
                height: 500,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 255, 255, 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                     Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        '$_realquestion/5',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        question?['question'],
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    ..._buildOptions(question?['choices']),
                    SizedBox(height: 30),
                    ElevatedButton(
                      onPressed:
                          _answered ? () => _nextQuestion() : null,
                      child: Text('Next Question'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFEB1555),
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        minimumSize: Size(330, 60),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildOptions(List<String> choices) {
    List<Widget> optionWidgets = [];
    for (int i = 0; i < choices.length; i++) {
      final bool isCorrect =
          (choices[i] == ques.getCorrectAnswer(_questionIndex));
      optionWidgets.add(
        GestureDetector(
          onTap: () {
            if (!_answered) {
              _handleAnswer(isCorrect);
            }
          },
          child: Container(
              width: 350.0,
              height: 50,
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: _answered
                    ? (isCorrect
                        ? Colors.green.withOpacity(0.7)
                        : Colors.red.withOpacity(0.7))
                    : Color.fromRGBO(255, 255, 255, 0.2),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        '${i + 1}. ${choices[i]}',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              )),
        ),
      );
    }
    return optionWidgets;
  }
}
