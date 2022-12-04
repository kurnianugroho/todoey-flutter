import 'package:flutter/material.dart';
import 'package:lib/add_task.dart';
import 'package:lib/task.dart';
import 'package:lib/task_list.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TaskList>(
      create: (BuildContext context) => TaskList(),
      builder: (context, child) {
        return Scaffold(
          backgroundColor: Colors.lightBlue,
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.lightBlue,
            foregroundColor: Colors.white,
            child: Icon(
              Icons.add,
              size: 36.0,
            ),
            onPressed: () {
              final taskList = Provider.of<TaskList>(context, listen: false);
              showModalBottomSheet(
                  context: context,
                  builder: (_) {
                    return ListenableProvider.value(
                        value: taskList, child: AddTask());
                  });
            },
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(left: 40.0, top: 80.0, right: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 40.0,
                      child: Icon(
                        Icons.list,
                        size: 64.0,
                        color: Colors.lightBlue,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 20.0),
                      child: Text(
                        'Todoey',
                        style: TextStyle(
                            fontSize: 44.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 2.0),
                      child: Text(
                        '${Provider.of<TaskList>(context).getTaskCount()} Tasks',
                        style: TextStyle(
                            fontSize: 24.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 30.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: ListView.builder(
                      itemCount: Provider.of<TaskList>(context).getTaskCount(),
                      itemBuilder: (context, index) {
                        Task? currentTask =
                            Provider.of<TaskList>(context).getTask(index);
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: GestureDetector(
                            onLongPress: () {
                              Provider.of<TaskList>(context, listen: false)
                                  .deleteTask(index);
                            },
                            child: Row(
                              children: [
                                Checkbox(
                                    value: currentTask?.isFinished,
                                    onChanged: (currValue) {
                                      if (currentTask != null) {
                                        currentTask.isFinished =
                                            currValue ?? false;
                                        Provider.of<TaskList>(context,
                                                listen: false)
                                            .updateTask(index, currentTask);
                                      }
                                    }),
                                Text(
                                  '${currentTask?.description}',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600,
                                      decoration:
                                          (currentTask?.isFinished ?? false)
                                              ? TextDecoration.lineThrough
                                              : null),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
