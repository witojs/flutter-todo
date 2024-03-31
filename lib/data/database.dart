import 'package:hive_flutter/hive_flutter.dart';

class ToDoDatabase {
  List toDoList = [];

  //reference the box
  final _myBox = Hive.box('mybox');

  //run method if first time opening the app
  void createInitialData(){
    toDoList = [
      ['make tutorial', false],
      ['Do execise', false],
    ];
  }

  //load the data from database
  void loadData(){
    toDoList = _myBox.get('TODOLIST');
  }

  //update the database
  void updateDataBase(){
    _myBox.put('TODOLIST', toDoList);
  }
}