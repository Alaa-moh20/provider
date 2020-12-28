import 'package:provider_ass/db_helper.dart';

class Task2 {
  String taskName;
  bool isComplete;
  Task2({this.taskName, this.isComplete});

  Task2.fromJson(Map map) {
    this.taskName = map[DBHelper.taskNameColumnName];
    this.isComplete =
        map[DBHelper.taskIsCompleteColumnName] == 1 ? true : false;
  }
  toJson() {
    return {
      DBHelper.taskNameColumnName: this.taskName,
      DBHelper.taskIsCompleteColumnName: this.isComplete ? 1 : 0
    };
  }
}
