import 'package:flutter/material.dart';
import 'package:table_app/constant.dart';
import 'package:table_app/input_page.dart';
import 'iconText.dart';
import 'container.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'result.dart';
import 'calculator.dart';
import 'mathTableRepository.dart';
import 'mathTablesDatabase.dart';

import 'quizTablesDatabase.dart';
import 'quizTableRepository.dart';

QuizTableRepository repository = QuizTableRepository();

class SavedQuiz extends StatefulWidget {
  @override
  _SavedQuizState createState() => _SavedQuizState();
}

class _SavedQuizState extends State<SavedQuiz> {
  List<Map<String, dynamic>> tableItems = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    List<QuizTable> allMathTables = await repository.getAllQuizTables();
    List<Map<String, dynamic>> newTableItems = [];

    for (int i = 0; i < allMathTables.length; i++) {
      bool tableExists =
          tableItems.any((item) => item['table_id'] == allMathTables[i].id);

      if (!tableExists) {
        Map<String, dynamic> table = {
          'table_id': allMathTables[i].id,
          'table_name': allMathTables[i].tableNumber,
          'quiz_type': allMathTables[i].quizType,
          'question_numbers': allMathTables[i].questionNumbers,
          'marks': allMathTables[i].marks,
        };

        newTableItems.add(table);
      }
    }

    setState(() {
      tableItems.addAll(newTableItems);
    });
  }

  void deleteTable(int id) async {
    await repository.deleteQuizTable(id);
    setState(() {
      tableItems.removeWhere((item) => item['table_id'] == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz List'),
      ),
     body: Container(
  padding: EdgeInsets.all(40),
  child: ListView.builder(
    itemCount: tableItems.length,
    itemBuilder: (context, index) {
      final item = tableItems[index];
      return Container(
        margin: EdgeInsets.only(bottom: 30),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Color(0xFF1D1E33),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Quiz ${item['table_id']+1}',
              style: kTitleStyleS5,
            ),
            SizedBox(height: 8),
            Text(
              'Quiz of table${item['table_name']}',
              style: kTitleStyleS5,
            ),
            SizedBox(height: 8),
            Text(
              'Score ${item['marks']}',
              style: kTitleStyleS5,
            ),
            SizedBox(height: 8),
            Text(
              'Correct answeres ${item['marks']}',
              style: kTitleStyleS5,
            ),
            SizedBox(height: 8),
            Text(
              'Incorrect answeres ${item['question_numbers']-item['marks']}',
              style: kTitleStyleS5,
            ),
            GestureDetector(
              onTap: () {
                deleteTable(item['table_id']);
              },
              child: Icon(
                FontAwesomeIcons.trash,
                color: Colors.red,
              ),
            ),
          ],
        ),
      );
    },
  ),
),

    );
  }
}
