import 'package:flutter/material.dart';
import 'package:lib/task.dart';
import 'package:lib/task_list.dart';
import 'package:provider/provider.dart';

class AddTask extends StatelessWidget {
  String description = '';

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.6,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(12.0),
              child: TextField(
                autofocus: true,
                onChanged: (newValue) {
                  description = newValue;
                },
                decoration: InputDecoration(
                    labelText: 'Task Description',
                    labelStyle: TextStyle(fontWeight: FontWeight.w600)),
                textAlign: TextAlign.center,
              ),
            ),
            ElevatedButton(
                child: Text(
                  'Add task',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Provider.of<TaskList>(context, listen: false)
                      .addTask(Task(description: description));
                  Navigator.pop(context);
                })
          ],
        ));
  }
}
