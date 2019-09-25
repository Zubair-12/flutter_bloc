import 'package:flutter/material.dart';
import 'Employee.dart';
import 'EmployeeBloc.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final EmployeeBloc _employeeBloc = EmployeeBloc();

  @override
  void dispose() {
    _employeeBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Employee App"),
      ),
      body: Container(
        child: StreamBuilder<List<Employee>>(
          stream: _employeeBloc.employeeListStream,
          builder:
              (BuildContext context, AsyncSnapshot<List<Employee>> snapshot) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 6.0,
                  child: Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          '${snapshot.data[index].id}.',
                          style: TextStyle(fontSize: 18.0),
                        ),
                        Container(
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            children: <Widget>[
                              Text(
                                '${snapshot.data[index].name}',
                                style: TextStyle(fontSize: 20.0),
                              ),
                              Text(
                                '${snapshot.data[index].salary.toStringAsFixed(2)}',
                                style: TextStyle(
                                    fontSize: 20.0, color: Colors.green),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: IconButton(
                            icon: Icon(Icons.thumb_up),
                            iconSize: 18.0,
                            color: Colors.green,
                            onPressed: () {
                              _employeeBloc.employeeSalaryInc
                                  .add(snapshot.data[index]);
                            },
                          ),
                        ),
                        Container(
                          child: IconButton(
                            icon: Icon(Icons.thumb_down),
                            iconSize: 18.0,
                            color: Colors.red,
                            onPressed: () {
                              _employeeBloc.employeeSalaryDec
                                  .add(snapshot.data[index]);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
