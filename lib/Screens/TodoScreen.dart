import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/Models/TaskData.dart';
import 'package:task_manager/Widgets/TodoList.dart';
import 'package:task_manager/Screens/BottomSheetBuilder.dart';
import 'package:task_manager/Models/DatabaseHelper.dart';
import 'package:task_manager/Models/Tasks.dart';

class TodoScreen extends StatefulWidget {
  static final id = 'todoScreen';
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final dbHelper = DatabaseHelper.instance;
  @override
  void initState() {
    super.initState();
    callingprevTasks();
  }

  void callingprevTasks() async {
    List tasks;
    tasks = await dbHelper.fetchTasks();
    for (int i = 0; i < tasks.length; i++) {
      print(tasks);
      Provider.of<TaskData>(context, listen: false).addPreviousTasks(Tasks(
          id: tasks[i]['_id'],
          isDone: tasks[i]['isDone'] == 0 ? false : true,
          name: tasks[i]['name']));
      Provider.of<TaskData>(context, listen: false).notifyListening();
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    TaskData taskData = TaskData();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlueAccent,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => SingleChildScrollView(
              child: BottomSheetBuilder(),
            ),
          );
        },
      ),
      backgroundColor: Colors.lightBlueAccent,
      body: RefreshIndicator(
        onRefresh: () async {
          List tasks;
          tasks = await dbHelper.fetchTasks();
          for (int i = 1; i < tasks.length; i++) {
            taskData.tasks.add(Tasks(
                id: tasks[i]['_id'],
                isDone: tasks[i]['isDone'] == 0 ? false : true,
                name: tasks[i]['name']));
            print(taskData.tasks.length);
          }

          return dbHelper.fetchTasks();
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: height * 0.4,
              width: width,
              padding: EdgeInsets.only(
                  bottom: height * 0.05,
                  top: height * 0.10,
                  left: height * 0.05,
                  right: height * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    child: Icon(
                      Icons.list,
                      color: Colors.lightBlueAccent,
                      size: height * 0.0455,
                    ),
                    backgroundColor: Colors.white,
                    radius: height * 0.035,
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  Text(
                    'Taskie',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: height * 0.06,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    '${Provider.of<TaskData>(context).tasklength} Tasks',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: height * 0.025,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                child: TodoList(),
                height: height * 0.50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0),
                  ),
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
