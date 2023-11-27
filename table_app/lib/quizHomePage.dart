import 'package:table_app/constant.dart';
import 'package:flutter/material.dart';
import 'package:table_app/input_page.dart';
import 'iconText.dart';
import 'container.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'result.dart';
import 'calculator.dart';

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
                    // Navigator.push(context,
                    // MaterialPageRoute(builder: (context) => InputPage()));
                  },
                  colors:
                      selectGender == Gender.male ? activeColor : deActiveColor,
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
            ]),
          )
        ]));
  }
}
