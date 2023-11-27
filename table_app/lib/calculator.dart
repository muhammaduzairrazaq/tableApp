import 'package:flutter/material.dart';
import 'package:table_app/constant.dart';

class CalculatorBrain {
  CalculatorBrain({this.number, this.lowerLimit, this.upperLimit});

  final int? number;
  final int? lowerLimit;
  final int? upperLimit;
Widget generateTable() {
  return ListView.builder(
    itemCount: upperLimit! - lowerLimit! + 1,
    itemBuilder: (context, index) {
      int current = lowerLimit! + index;
      return ListTile(
        title: Text(
          '$number x $current = ${number! * current}',
          style: kTitleStyleS3,
        ),
      );
    },
  );
}

}
