import 'package:flutter/material.dart';

class TodoTile extends StatelessWidget {
  TodoTile(
      {this.tileText,
      this.isChecked,
      this.taskCheckedCallback,
      this.deleteTaskCallback});
  final String tileText;
  final taskCheckedCallback;
  final bool isChecked;
  final deleteTaskCallback;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        tileText,
        style: TextStyle(
            decoration: isChecked ? TextDecoration.lineThrough : null),
      ),
      trailing: Checkbox(
        activeColor: Colors.lightBlueAccent,
        checkColor: Colors.white,
        value: isChecked,
        onChanged: taskCheckedCallback,
      ),
      onLongPress: deleteTaskCallback,
    );
  }
}
