import 'dart:async';
import 'Employee.dart';

class EmployeeBloc {
  List<Employee> _employeeList = [
    Employee(1, "User 1 ", 10000),
    Employee(2, "User 2 ", 20000),
    Employee(3, "User 3 ", 30000),
    Employee(4, "User 4 ", 40000),
    Employee(5, "User 5 ", 50000),
  ];

  // * Stream controller takes a List of Employee Objects as an argument
  final _employeeListStreamController = StreamController<List<Employee>>();

  // * Increment Salary StreamController takes Employee object as an argument
  final _employeeSalaryIncStreamController = StreamController<Employee>();

  // * Increment Salary StreamController takes Employee object as an argument
  final _employeeSalaryDecStreamController = StreamController<Employee>();

  // ! Stream is actual output of data
  Stream<List<Employee>> get employeeListStream =>
      _employeeListStreamController.stream;

  // ! Sink is actual input of data
  StreamSink<List<Employee>> get employeeListSink =>
      _employeeListStreamController.sink;

  StreamSink<Employee> get employeeSalaryInc =>
      _employeeSalaryIncStreamController.sink;

  StreamSink<Employee> get employeeSalaryDec =>
      _employeeSalaryDecStreamController.sink;

  // ! Contructor init data and listen to changes done by methods
  EmployeeBloc() {
    // * this is actual data
    _employeeListStreamController.add(_employeeList);

    // * Methods that changes data need to listen
    _employeeSalaryIncStreamController.stream.listen(_incSalary);
    _employeeSalaryDecStreamController.stream.listen(_decSalary);
  }

  _incSalary(Employee emp) {
    double sal = emp.salary;

    double incSal = sal * 0.2;
    _employeeList[emp.id - 1].salary = sal + incSal;

    employeeListSink.add(_employeeList);
  }

  _decSalary(Employee emp) {
    double sal = emp.salary;

    double decSal = sal * 0.2;
    _employeeList[emp.id - 1].salary = sal - decSal;

    employeeListSink.add(_employeeList);
  }

  // ! dispose() helps to free up the resources
  void dispose() {
    _employeeSalaryIncStreamController.close();
    _employeeSalaryDecStreamController.close();
    _employeeListStreamController.close();
  }
}
