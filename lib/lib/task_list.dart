import 'package:flutter/material.dart';
import 'package:lib/task.dart';

class TaskList extends ChangeNotifier {
  List<Task> _taskList = [];

  void addTask(Task task) {
    _taskList.add(task);
    notifyListeners();
  }

  Task? getTask(int index) {
    return _taskList[index];
  }

  int getTaskCount() {
    return _taskList.length;
  }

  void updateTask(int index, Task task) {
    _taskList[index] = task;
    notifyListeners();
  }

  void deleteTask(int index) {
    _taskList.removeAt(index);
    notifyListeners();
  }
}
