import 'package:table_app/constant.dart';
import 'package:table_app/container.dart';
import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final Widget numberTable;
  final int? number;

  ResultScreen({required this.numberTable, required this.number});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Generated Table'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              child: Center(
                child: Text(
                  'Table of $number',
                  style: kTitleStyleS2,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: ContainerWidget(
              colors: activeColor,
              cardWidget: Column(
                children: [
                  Expanded(child: numberTable),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
