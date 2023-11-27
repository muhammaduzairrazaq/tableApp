import 'package:flutter/material.dart';
import 'package:table_app/constant.dart';
import 'package:table_app/quizHomePage.dart';

class ScoreScreen extends StatelessWidget {
  final int score;
  ScoreScreen({required this.score});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Container(
            width: 350,
            height: 400,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (score < 4)
                  Image.asset(
                    'assets/badluck.gif', 
                    width: 150,
                    height: 150,
                  ),
                if (score >= 4)
                  Image.asset(
                    'assets/congratulations.gif', 
                    width: 150,
                    height: 150,
                  ),
                SizedBox(height: 15),
                Text(
                  '$score',
                  style: labelStyle2,
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QuizHomePage(),
                      ),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Color(0xFFEB1555)),
                  ),
                  child: Container(
                    width: 100,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Center(
                      child: Text(
                        'Start Again',
                        style: kTitleStyleS4,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
