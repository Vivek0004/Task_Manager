class Tasks {
  String name;
  bool isDone = false;
  int id;
  Tasks({this.name, this.isDone, this.id});

  void toggleCheckbox() {
    isDone = !isDone;
  }

  Tasks.fromMap(Map<String, dynamic> map) {
    id = map['_id'];
    name = map['name'];
    isDone = map['isDone'] == 0 ? false : true;
  }
}
