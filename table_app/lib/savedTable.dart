import 'package:flutter/material.dart';
import 'package:table_app/constant.dart';
import 'package:table_app/input_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'result.dart';
import 'calculator.dart';
import 'mathTableRepository.dart';
import 'mathTablesDatabase.dart';

MathTableRepository repository = MathTableRepository();

class SavedTable extends StatefulWidget {
  @override
  _SavedTableState createState() => _SavedTableState();
}

class _SavedTableState extends State<SavedTable> {
  List<Map<String, dynamic>> tableItems = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void updateTable(int id) async {
    MathTable? mathTable = await repository.getMathTableById(id);
    int indexToUpdate = tableItems.indexWhere((item) => item['table_id'] == id);
    if (indexToUpdate != -1) {
      setState(() {
        tableItems[indexToUpdate]['table_name'] = mathTable?.tableNumber;
        tableItems[indexToUpdate]['lower_limit'] = mathTable?.lowerLimit;
        tableItems[indexToUpdate]['upper_limit'] = mathTable?.upperLimit;
      });
    }
  }

  void fetchData() async {
    List<MathTable> allMathTables = await repository.getAllMathTables();
    List<Map<String, dynamic>> newTableItems = [];

    for (int i = 0; i < allMathTables.length; i++) {
      bool tableExists =
          tableItems.any((item) => item['table_id'] == allMathTables[i].id);

      if (!tableExists) {
        Map<String, dynamic> table = {
          'table_id': allMathTables[i].id,
          'table_name': allMathTables[i].tableNumber,
          'lower_limit': allMathTables[i].lowerLimit,
          'upper_limit': allMathTables[i].upperLimit,
        };

        newTableItems.add(table);
      }
    }

    setState(() {
      tableItems.addAll(newTableItems);
    });
  }

  void deleteTable(int id) async {
    await repository.deleteMathTable(id);
    setState(() {
      tableItems.removeWhere((item) => item['table_id'] == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Table List'),
      ),
      body: Container(
        padding: EdgeInsets.all(40),
        child: ListView.builder(
          itemCount: tableItems.length,
          itemBuilder: (context, index) {
            final item = tableItems[index];
            return GestureDetector(
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InputPage(
                      tablenumber: item['table_name'],
                      lowerlimit: item['lower_limit'],
                      upperlimit: item['upper_limit'],
                      edit: true,
                      id: item['table_id'],
                    ),
                  ),
                );
                updateTable(item['table_id']);
              },
              child: Card(
                margin: EdgeInsets.only(bottom: 30),
                color: Color(0xFF1D1E33),
                child: ListTile(
                  title: Text(
                    'Table of ${item['table_name']}',
                    style: kTitleStyleS5,
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () {
                          CalculatorBrain clac = CalculatorBrain(
                              number: item['table_name'],
                              lowerLimit: item['lower_limit'],
                              upperLimit: item['upper_limit']);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ResultScreen(
                                        numberTable: clac.generateTable(),
                                        number: item['table_name'],
                                      )));
                        },
                        child: Icon(
                          FontAwesomeIcons.calculator,
                          color: Color.fromARGB(255, 76, 175, 145),
                        ),
                      ),
                      SizedBox(width: 16),
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
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
