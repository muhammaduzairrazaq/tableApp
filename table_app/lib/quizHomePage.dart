import 'package:table_app/constant.dart';
import 'package:flutter/material.dart';
import 'package:table_app/input_page.dart';
import 'package:table_app/questionScreen.dart';
import 'package:table_app/truefalseScreen.dart';
import 'iconText.dart';
import 'container.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'questionGenerator.dart';
import 'truefalseGenerator.dart';
import 'questionScreen.dart';
import 'result.dart';
import 'calculator.dart';

Questions ques = Questions();
TruefalseQuestions tfques = TruefalseQuestions();


enum Gender {
  male,
  female,
}

class QuizHomePage extends StatefulWidget {
  @override
  _QuizHomePageState createState() => _QuizHomePageState();
}

class _QuizHomePageState extends State<QuizHomePage> {
  Gender? selectGender;
  int sliderTable = 5;
  int sliderLowerLimit = 1;
  int sliderUpperLimit = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Table App'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: ContainerWidget(
                    onPressed: () {
                      setState(() {
                        selectGender = Gender.male;
                      });
                      ques.generateQuestions();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QuestionsScreen(),
                        ),
                      );
                    },
                    colors: selectGender == Gender.male
                        ? activeColor
                        : deActiveColor,
                    cardWidget: IconText(
                      icondata: FontAwesomeIcons.listCheck,
                      lable: 'Multiple Choice',
                    ),
                  ),
                ),
                Expanded(
                  child: ContainerWidget(
                    onPressed: () {
                      setState(() {
                        selectGender = Gender.female;
                      });
                      tfques.generateQuestions();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TruefalseScreen(),
                        ),
                      );
                    },
                    colors: selectGender == Gender.female
                        ? activeColor
                        : deActiveColor,
                    cardWidget: IconText(
                      icondata: FontAwesomeIcons.t,
                      lable: 'True False',
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ContainerWidget(
              colors: Color(0xFF1D1E33),
              cardWidget: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Select Total Questions',
                    style: labelStyle,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(sliderTable.toString(), style: labelStyle2),
                    ],
                  ),
                  Slider(
                    value: sliderTable.toDouble(),
                    min: 1.0,
                    max: 10.0,
                    activeColor: Color(0xFFEB1555),
                    inactiveColor: Color(0xFF8D8E98),
                    onChanged: (double newValue) {
                      setState(() {
                        sliderTable = newValue.round();
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
