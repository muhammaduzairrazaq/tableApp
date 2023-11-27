import 'package:table_app/constant.dart';
import 'package:flutter/material.dart';
import 'iconText.dart';
import 'container.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'result.dart';
import 'calculator.dart';


enum Gender {
  male,
  female,
}

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  Gender? selectGender;
  int sliderTable = 1;
  int sliderLowerLimit = 1;
  int sliderUpperLimit = 10;



  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Table App'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Row(children: [
                Expanded(
                  child: ContainerWidget(
                    onPressed: () {
                      setState(() {
                        selectGender = Gender.male;
                      });
                    },
                    colors: selectGender == Gender.male
                        ? activeColor
                        : deActiveColor,
                    cardWidget: IconText(
                      icondata: FontAwesomeIcons.male,
                      lable: 'Male',
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
                      icondata: FontAwesomeIcons.female,
                      lable: 'Female',
                    ),
                  ),
                ),
              ]),
            ),
            Expanded(
              child: ContainerWidget(
                colors: Color(0xFF1D1E33),
                cardWidget: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Select Number',
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
                        })
                  ],
                ),
              ),
            ),
            Expanded(
              child: Row(children: [
                Expanded(
                    child: ContainerWidget(
                        colors: Color(0xFF1D1E33),
                        cardWidget: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Lower Limit',
                              style: labelStyle,
                            ),
                            Text(
                              sliderLowerLimit.toString(),
                              style: labelStyle2,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RoundIcon(
                                    iconData: FontAwesomeIcons.minus,
                                    onPress: () {
                                      setState(() {
                                        sliderLowerLimit--;
                                      });
                                    }),
                                SizedBox(
                                  width: 10.0,
                                ),
                                RoundIcon(
                                    iconData: FontAwesomeIcons.plus,
                                    onPress: () {
                                      setState(() {
                                        sliderLowerLimit++;
                                      });
                                    })
                              ],
                            )
                          ],
                        ))),
                Expanded(
                  child: ContainerWidget(
                      colors: Color(0xFF1D1E33),
                      cardWidget: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Upper Limit',
                            style: labelStyle,
                          ),
                          Text(
                            sliderUpperLimit.toString(),
                            style: labelStyle2,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RoundIcon(
                                  iconData: FontAwesomeIcons.minus,
                                  onPress: () {
                                    setState(() {
                                      sliderUpperLimit--;
                                    });
                                  }),
                              SizedBox(
                                width: 10.0,
                              ),
                              RoundIcon(
                                  iconData: FontAwesomeIcons.plus,
                                  onPress: () {
                                    setState(() {
                                      sliderUpperLimit++;
                                    });
                                  })
                            ],
                          )
                        ],
                      )),
                ),
              ]),
            ),
            GestureDetector(
              onTap: () {
                CalculatorBrain clac = CalculatorBrain(number: sliderTable, lowerLimit: sliderLowerLimit, upperLimit: sliderUpperLimit);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ResultScreen(numberTable: clac.generateTable(), number: sliderTable,)));
              },
              child: Container(
                child: Center(
                  child: Text(
                    'Calculate',
                    style: labelStyle3,
                  ),
                ),
                color: Color(0xFFEB1555),
                margin: EdgeInsets.only(top: 10.0),
                width: double.infinity,
                height: 80.0,
              ),
            )
          ],
        ));
  }
}

class RoundIcon extends StatelessWidget {
  RoundIcon({required this.iconData, required this.onPress});
  final IconData iconData;
  final VoidCallback? onPress;
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      child: Icon(iconData),
      onPressed: onPress,
      elevation: 6.0,
      constraints: BoxConstraints.tightFor(
        height: 56.0,
        width: 56.0,
      ),
      shape: CircleBorder(),
      fillColor: Color(0xFF4C4F5E),
    );
  }
}
