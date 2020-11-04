import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/Models/TaskData.dart';
import 'package:task_manager/Widgets/TodoTile.dart';

class TodoList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      key: key,
      builder: (context, taskdata, child) {
        return ListView.builder(
          itemBuilder: (context, index) {
            final task = taskdata.tasks[index];
            return TodoTile(
              tileText: task.name,
              isChecked: task.isDone,
              taskCheckedCallback: (checkboxdata) {
                taskdata.taskToggler(task);
              },
              deleteTaskCallback: () {
                //Provider.of<TaskData>(context, listen: false).deleteTask(task);
                taskdata.deleteTask(task);
              },
            );
          },
          itemCount: taskdata.tasklength,
        );
      },
    );
  }
}
