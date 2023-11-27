import 'package:table_app/constant.dart';
import 'package:flutter/material.dart';
import 'package:table_app/input_page.dart';
import 'iconText.dart';
import 'container.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'quizHomePage.dart';
import 'result.dart';
import 'calculator.dart';


enum Gender {
  male,
  female,
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Gender? selectGender;
  int sliderTable = 1;
  int sliderLowerLimit = 1;
  int sliderUpperLimit = 10;

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Table App'),
        ),
        body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Expanded(
            child: Row(children: [
              Expanded(
                child: ContainerWidget(
                  onPressed: () {
                    setState(() {
                      selectGender = Gender.male;
                    });
                    Navigator.push(context,
                    MaterialPageRoute(builder: (context) => InputPage()));
                  },
                  colors:
                      selectGender == Gender.male ? activeColor : deActiveColor,
                  cardWidget: IconText(
                    icondata: FontAwesomeIcons.calculator,
                    lable: 'Generate Table',
                  ),
                ),
              ),
              Expanded(
                child: ContainerWidget(
                  onPressed: () {
                    setState(() {
                      selectGender = Gender.female;
                    });
                     Navigator.push(context,
                    MaterialPageRoute(builder: (context) => QuizHomePage()));
                  },
                  colors: selectGender == Gender.female
                      ? activeColor
                      : deActiveColor,
                  cardWidget: IconText(
                    icondata: FontAwesomeIcons.penToSquare,
                    lable: 'Take Quiz',
                  ),
                ),
              ),
            ]),
          )
        ]));
  }
}
