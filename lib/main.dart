import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/Models/TaskData.dart';
import 'Screens/TodoScreen.dart';

void main() {
  runApp(TodoeyApp());
}

class TodoeyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskData(),
      child: MaterialApp(
        initialRoute: TodoScreen.id,
        routes: {
          TodoScreen.id: (context) => TodoScreen(),
        },
      ),
    );
  }
}
