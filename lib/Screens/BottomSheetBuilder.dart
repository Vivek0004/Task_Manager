import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/Models/TaskData.dart';

class BottomSheetBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String newTask;
    TextEditingController textEditingController;
    return Container(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        color: Color(0xFF757575),
        child: Container(
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Add Task',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.lightBlueAccent,
                    fontSize: 30.0,
                    fontWeight: FontWeight.w500),
              ),
              TextField(
                controller: textEditingController,
                onChanged: (addedTask) {
                  newTask = addedTask;
                },
                autofocus: true,
                textAlign: TextAlign.center,
                cursorColor: Colors.lightBlueAccent,
                cursorRadius: Radius.circular(3),
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  focusColor: Colors.lightBlueAccent,
                ),
              ),
              FlatButton(
                onPressed: () {
                  print(newTask);
                  if (newTask != null) {
                    Provider.of<TaskData>(context, listen: false)
                        .addTaskTitle(newTask);
                    Navigator.pop(context);
                  }
                },
                color: Colors.lightBlueAccent,
                child: Text(
                  'Add',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
