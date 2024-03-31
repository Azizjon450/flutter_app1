import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';

import 'package:flutter_app1/utility/dialog_box.dart';
import 'package:flutter_app1/utility/todo_tile.dart';
import 'package:flutter_app1/data/database.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //reference the hive box
  final _mybox = Hive.box('mybox');
  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
    //this is is the first time ever opening the app, then create default data
    if(_mybox.get("TODOLIST") == null) {
      db.createInitialData();
    }else{
      //already exist data
      db.loadData();
    }

    super.initState();
  }

  // text controller
  final _controller = TextEditingController();

  // checkBox on tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoLists[index][1] = !db.toDoLists[index][1];
    });
    db.updateDataBase();
  }

  // save new task
  void saveNewTask() {
    setState(() {
      db.toDoLists.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  //create new tasks
  void createNewTasks() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: () => saveNewTask(),
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  //delete task
  void deleteTask(int index) {
    setState(() {
      db.toDoLists.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: Text("TO DO"),
        backgroundColor: Colors.yellow,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          createNewTasks();
        },
        backgroundColor: Colors.yellow,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: db.toDoLists.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskname: db.toDoLists[index][0],
            taskCompleted: db.toDoLists[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteFunction: (context) => deleteTask(index),
          );
        },
      ),
    );
  }
}
