import 'package:table_app/QuizParameters.dart';
import 'package:table_app/constant.dart';
import 'package:flutter/material.dart';
import 'package:table_app/questionScreen.dart';
import 'package:table_app/truefalseScreen.dart';
import 'iconText.dart';
import 'container.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'questionGenerator.dart';
import 'truefalseGenerator.dart';
import 'mathTableRepository.dart';
import 'mathTablesDatabase.dart';

Questions ques = Questions();
TruefalseQuestions tfques = TruefalseQuestions();

MathTableRepository repository = MathTableRepository();

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

  int sliderTableNumber = 1;

  List<Map<String, dynamic>> tableItems = [];
  List<int> storedTables = [];

  void fetchTableNumbers() async {
    storedTables.clear();
    List<MathTable> allMathTables = await repository.getAllMathTables();
    for (int i = 0; i < allMathTables.length; i++) {
      bool tableExists =
          tableItems.any((item) => item['table_id'] == allMathTables[i].id);

      if (!tableExists) {
        storedTables.add(allMathTables[i].tableNumber);
      }
    }
    storedTables.sort();
  }

  @override
  void initState() {
    super.initState();
    fetchTableNumbers();
  }

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
                        selectGender = Gender.female;

                        QuizParameters.questionNumbers = sliderTable;
                        QuizParameters.tableNumber = sliderTableNumber;
                        QuizParameters.lowerLimit = 1;
                        QuizParameters.upperLimit = 10;
                        ques.generateQuestions();
                      });

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

                        QuizParameters.questionNumbers = sliderTable;
                        QuizParameters.tableNumber = sliderTableNumber;
                        QuizParameters.lowerLimit = 1;
                        QuizParameters.upperLimit = 10;
                        tfques.generateQuestions();
                      });

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
                    'Select Table Number',
                    style: labelStyle,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(sliderTableNumber.toString(), style: labelStyle2),
                    ],
                  ),
                  Slider(
                    value: sliderTableNumber.toDouble(),
                    min: storedTables.isNotEmpty
                        ? storedTables.first.toDouble()
                        : 1.0,
                    max: storedTables.isNotEmpty
                        ? storedTables.last.toDouble()
                        : 10.0,
                    activeColor: Color(0xFFEB1555),
                    inactiveColor: Color(0xFF8D8E98),
                    onChanged: (value) {
                      setState(() {
                        if (storedTables.isNotEmpty) {
                          sliderTableNumber = storedTables.reduce(
                            (prev, curr) => (curr - value.round()).abs() <
                                    (prev - value.round()).abs()
                                ? curr
                                : prev,
                          );
                        }
                      });
                    },
                  ),
                  SizedBox(
                    height: 17.0,
                  ),
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
