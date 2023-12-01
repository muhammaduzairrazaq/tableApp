import 'package:table_app/constant.dart';
import 'package:flutter/material.dart';
import 'container.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'result.dart';
import 'calculator.dart';
import 'mathTableRepository.dart';
import 'mathTablesDatabase.dart';
import 'package:flutter/material.dart' hide VoidCallback;
import 'dart:ui' as ui;

MathTableRepository repository = MathTableRepository();

enum Gender {
  male,
  female,
}

// ignore: must_be_immutable
class InputPage extends StatefulWidget {
  @override
  InputPageState createState() => InputPageState();

  int slidertable = 0;
  int sliderlowerlimit = 0;
  int sliderupperlimit = 0;
  int tableid = 0;
  bool editingg = false;

  InputPage(
      {super.key,
      int tablenumber = 1,
      int lowerlimit = 1,
      int upperlimit = 10,
      bool edit = false,
      int id = 1}) {
    slidertable = tablenumber;
    sliderlowerlimit = lowerlimit;
    sliderupperlimit = upperlimit;
    tableid = id;
    editingg = edit;
  }
}

class InputPageState extends State<InputPage> {
  Gender? selectGender;
  int sliderTable = 0;
  int sliderLowerLimit = 0;
  int sliderUpperLimit = 0;
  int tableId = 0;
  bool editing = false;

  String buttonName = 'Generate';

  @override
  void initState() {
    super.initState();
    sliderTable = widget.slidertable;
    sliderLowerLimit = widget.sliderlowerlimit;
    sliderUpperLimit = widget.sliderupperlimit;
    editing = widget.editingg;
    tableId = widget.tableid;

    if (editing) {
      buttonName = 'Edit';
    }
  }

  void save_to_database() async {
    MathTable newMathTable = MathTable(
      id: 1,
      tableNumber: sliderTable,
      lowerLimit: sliderLowerLimit,
      upperLimit: sliderUpperLimit,
    );
    await repository.addMathTable(newMathTable);
  }

  void update_to_database() async {
    MathTable? mathTableById = await repository.getMathTableById(tableId);

    if (mathTableById != null) {
      mathTableById.tableNumber = sliderTable;
      mathTableById.lowerLimit = sliderLowerLimit;
      mathTableById.upperLimit = sliderUpperLimit;

      await repository.updateMathTable(mathTableById);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Generate Table'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
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
                if (editing) {
                  update_to_database();
                } else {
                  save_to_database();
                  CalculatorBrain clac = CalculatorBrain(
                      number: sliderTable,
                      lowerLimit: sliderLowerLimit,
                      upperLimit: sliderUpperLimit);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ResultScreen(
                                numberTable: clac.generateTable(),
                                number: sliderTable,
                              )));
                }
              },
              child: Container(
                child: Center(
                  child: Text(
                    '$buttonName',
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
  final ui.VoidCallback? onPress;
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
