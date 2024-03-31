import 'package:hive/hive.dart';

class ToDoDataBase{
  //default list
  List toDoLists = [];

  //reference our box
  final _mybox = Hive.box('mybox');

  //run this method first time opening this App
  void createInitialData() {
    toDoLists = [
      ['First task', false],
      ['Second task', false],
    ];
  }

  //load the data from the database
  void loadData() {
    toDoLists = _mybox.get("TODOLIST");
  }

  //update the databse
  void updateDataBase() {
    _mybox.put("TODOLIST", toDoLists);
  }
}