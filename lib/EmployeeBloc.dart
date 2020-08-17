import 'dart:async';
import 'Employee.dart';

class EmployeeBloc {

  List<Employee> lstEmployee=[
    Employee(1, "ABC",10000),
    Employee(2, "ABC",20000),
    Employee(3, "ABC",30000),
    Employee(4, "ABC",40000),
    Employee(5, "ABC",50000),
  ];

 // Comtrollers

final _employeeListStreamController = StreamController<List<Employee>>();
final _employeeSalaryIncrementStreamController = StreamController<Employee>();
final _employeeSalaryDecrementStreamController = StreamController<Employee>();

// Getter

Stream<List<Employee>> get employeeListStream => _employeeListStreamController.stream;
StreamSink<List<Employee>> get employeeListStreamSink => _employeeListStreamController.sink;
StreamSink<Employee> get employeeSalaryIncrementSink => _employeeSalaryIncrementStreamController.sink;
StreamSink<Employee> get employeeSalaryDecrementSink => _employeeSalaryDecrementStreamController.sink;


EmployeeBloc()
{
  _employeeListStreamController.add(lstEmployee);
  _employeeSalaryIncrementStreamController.stream.listen(_incrementSalary);
  _employeeSalaryDecrementStreamController.stream.listen(_decrementSalary);
}

  _incrementSalary(Employee employee)
  {
    double salary = employee.salary;
    double increment = salary*0.2;
    lstEmployee[employee.id-1].salary=salary+increment;
    employeeListStreamSink.add(lstEmployee);
  }

  _decrementSalary(Employee employee)
  {
    double salary = employee.salary;
    double decrement = salary*0.2;
    lstEmployee[employee.id-1].salary=salary-decrement;
    employeeListStreamSink.add(lstEmployee);
  }

  void dispose()
  {
    _employeeListStreamController.close();
    _employeeSalaryIncrementStreamController.close();
    _employeeSalaryDecrementStreamController.close();
  }


}



