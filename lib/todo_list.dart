import 'package:flutter/material.dart';

class TodoListPage extends StatefulWidget {
  @override
  _TodoListPageState createState() => _TodoListPageState();
}

enum ShowType { all, todo, done }

class _TodoListPageState extends State<TodoListPage> {

  var _todo = <String, bool>{};
  var _text;
  var _showType = ShowType.all;

  @override
  Widget build(BuildContext context) {
    var textField = TextField(
      controller: new TextEditingController(text: this._text),
      keyboardType: TextInputType.text,
      textAlign: TextAlign.start,
      cursorColor: Colors.blue,
      style: TextStyle(
          fontSize: 16, color: Colors.lightBlue, backgroundColor: Colors.white),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: 'New a todo',
        hintStyle: TextStyle(color: Colors.black26, fontSize: 14),
        contentPadding: EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
        ),
      ),
      onChanged: (str) {
        _text = str;
      },
    );

    var btn = RaisedButton(
      child: Icon(Icons.add),
      padding: EdgeInsets.zero,
      onPressed: () {
        FocusScope.of(context).requestFocus(FocusNode());
        if (_text != null && _text != "") {
          _todo[_text] = false;
          _text = "";
          setState(() {});
        }
      },
    );

    var inputBtn = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          child: textField,
          width: 200,
          height: 40,
        ),
        ClipRRect(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
          child: Container(
            child: btn,
            width: 40,
            height: 40,
          ),
        ),
      ],
    );

    var op = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        RaisedButton(
          color: _showType == ShowType.all ? Colors.blue : null,
          textTheme: _showType == ShowType.all ? ButtonTextTheme.primary : ButtonTextTheme.normal,
          onPressed: () {
            _showType = ShowType.all;
            setState(() {});
          },
          child: Text("All"),
        ),
        RaisedButton(
          color: _showType == ShowType.done ? Colors.blue : null,
          textTheme: _showType == ShowType.done ? ButtonTextTheme.primary : ButtonTextTheme.normal,
          onPressed: () {
            _showType = ShowType.done;
            setState(() {});
          },
          child: Text("Done"),
        ),
        RaisedButton(
          color: _showType == ShowType.todo ? Colors.blue : null,
          textTheme: _showType == ShowType.todo ? ButtonTextTheme.primary : ButtonTextTheme.normal,
          onPressed: () {
            _showType = ShowType.todo;
            setState(() {});
          },
          child: Text("Todo"),
        ),
      ],
    );

    return Scaffold(
        appBar: AppBar(
          title: Text('Todo List'),
        ),
        body:  Column(
          children: <Widget>[inputBtn, op, Expanded(child: showList(_showType))],
        )
    );
  }

  showList(ShowType showType) {
    switch (showType) {
      case ShowType.all:
        return buildList(_todo);
        break;
      case ShowType.todo:
        return buildList(Map.fromEntries(_todo.entries.where((e) => !e.value)));
        break;
      case ShowType.done:
        return buildList(Map.fromEntries(_todo.entries.where((e) => e.value)));
        break;
    }
  }

  Widget buildList(Map<String, bool> todo) {
    return ListView.builder(
      itemCount: todo.length,
      padding: EdgeInsets.all(8.0),
      itemExtent: 50.0,
      itemBuilder: (BuildContext context, int index) {
        var key = todo.keys.toList()[index];
        var value = todo.values.toList()[index];
        var text = Align(
          child: Text(
            todo.keys.toList()[index],
            style: TextStyle(
              decorationThickness: 3,
                decoration: value
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
                decorationColor: Colors.blue),
          ),
          alignment: Alignment.centerLeft,
        );

        return Card(
          child: Row(
            children: <Widget>[
              Checkbox(
                onChanged: (b) {
                  _todo[key] = b;
                  setState(() {});
                },
                value: todo.values.toList()[index],
              ),
              text
            ],
          ),
        );
      },
    );
  }
}
