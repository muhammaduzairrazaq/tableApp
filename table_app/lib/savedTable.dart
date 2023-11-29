import 'package:table_app/constant.dart';
import 'package:flutter/material.dart';
import 'package:table_app/input_page.dart';
import 'iconText.dart';
import 'container.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'result.dart';
import 'calculator.dart';
import 'mathTableRepository.dart';
import 'mathTablesDatabase.dart';

MathTableRepository repository = MathTableRepository();

List<Map<String, dynamic>> tableItems = [];

enum Gender {
  male,
  female,
}

class SavedTable extends StatefulWidget {
  @override
  SavedTableState createState() => SavedTableState();
}

class SavedTableState extends State<SavedTable> {
  Gender? selectGender;
  int sliderTable = 1;
  int sliderLowerLimit = 1;
  int sliderUpperLimit = 10;

  @override
  void initState() {
    super.initState();
    get_all_tables();
  }

  void get_all_tables() async {
    List<MathTable> allMathTables = await repository.getAllMathTables();
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

        tableItems.add(table);
      }
    }

    print(tableItems);
  }

  void delete_table(int id) async {
await repository.deleteMathTable(id);
  }

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
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => InputPage(
                              tablenumber: item['table_name'],
                              lowerlimit: item['lower_limit'],
                              upperlimit: item['upper_limit'],
                              edit: true,
                              id: item['table_id'],
                            )));
              },
              child: Card(
                margin: EdgeInsets.only(bottom: 30),
                color: Color(0xFF1D1E33),
                child: ListTile(
                  title: Text(
                    'Table of ${item['table_name']}',
                    style: kTitleStyleS3,
                  ),
                  trailing: GestureDetector(
                    onTap: () {
                      delete_table(item['table_id']);
                    },
                    child: Icon(
                      FontAwesomeIcons.trash,
                      color: Colors.red,
                    ),
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
