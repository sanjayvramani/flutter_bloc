import 'package:flutter/material.dart';
import 'Employee.dart';
import 'EmployeeBloc.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

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

        title: Text(widget.title),
      ),
      body: Container(
        child: StreamBuilder<List<Employee>>(
            stream: _employeeBloc.employeeListStream,
            builder: (context,snapshot){
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context,index){
                    return Card(
                      elevation: 5.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(20.0),
                            child: Text("${snapshot.data[index].id}",style: TextStyle(fontSize: 20.0),),
                          ),
                          Container(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${snapshot.data[index].name}",style: TextStyle(fontSize: 20.0),),
                                Text("${snapshot.data[index].salary}",style: TextStyle(fontSize: 20.0),)
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(20.0),
                            child: Row(
                              children: [
                                IconButton(icon: Icon(Icons.thumb_up,color: Colors.green,), onPressed: (){
                                  _employeeBloc.employeeSalaryIncrementSink.add(snapshot.data[index]);
                                }),
                                IconButton(icon: Icon(Icons.thumb_down,color: Colors.red,), onPressed: (){
                                  _employeeBloc.employeeSalaryDecrementSink.add(snapshot.data[index]);
                                }),

                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  });
            }),
      ),

    );
  }
}
