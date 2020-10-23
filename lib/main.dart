import 'package:flutter/material.dart';
import 'package:flutter_demo/timer.dart';
import 'package:flutter_demo/todo_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Flutter demos'),
        ),
        body: Center(
          child: Column(children: [
            RaisedButton(
                child: Text("Todo List"),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                    return TodoListPage();
                  }));
                }),
            RaisedButton(
                child: Text("Timer"),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                    return TimerPage();
                  }));
                })
          ]),
        ));
  }
}
