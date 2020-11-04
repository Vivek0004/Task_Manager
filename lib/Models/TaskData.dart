import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:task_manager/Models/Tasks.dart';
import 'package:flutter/foundation.dart';
import 'DatabaseHelper.dart';

class TaskData extends ChangeNotifier {
  final dbHelper = DatabaseHelper.instance;
  List<Tasks> _tasks = [];

  int get tasklength {
    return _tasks.length;
  }

  void notifyListening() {
    notifyListeners();
  }

  UnmodifiableListView<Tasks> get tasks {
    return UnmodifiableListView(_tasks);
  }

  void addPreviousTasks(Tasks prevTasks) {
    _tasks.add(prevTasks);
  }

  void addTaskTitle(String newTitle) async {
    Map<String, dynamic> row = {
      DatabaseHelper.columnName: newTitle,
      DatabaseHelper.columnAge: 0
    };
    final id = await dbHelper.insert(row);
    print('inserted row id: $id');
    final task = Tasks(name: newTitle, id: id, isDone: false);
    _tasks.add(task);
    notifyListeners();
  }

  void taskToggler(Tasks task) async {
    task.toggleCheckbox();
    Map<String, dynamic> row = {
      DatabaseHelper.columnId: task.id,
      DatabaseHelper.columnName: task.name,
      DatabaseHelper.columnAge: task.isDone == true ? 0 : 1,
    };

    final rowsAffected = await dbHelper.update(row);
    print('updated $rowsAffected row(s)');
    print("id: ${task.id}");
    print(task.isDone);
    notifyListeners();
  }

  void deleteTask(Tasks task) async {
    _tasks.remove(task);
    final rowsDeleted = await dbHelper.delete(task.id);
    print('deleted $rowsDeleted row(s): row ${task.id}');
    notifyListeners();
  }
}
